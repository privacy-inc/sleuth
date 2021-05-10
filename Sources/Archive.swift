import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public var date: Date
    public internal(set) var settings: Settings
    public internal(set) var pages: [Page]
    public internal(set) var activity: [Date]
    public internal(set) var blocked: [String: [Date]]
    var counter = 0
    
    public var data: Data {
        Data()
            .adding(UInt16(counter))
            .adding(date)
            .adding(UInt16(pages.count))
            .adding(pages.flatMap(\.data))
            .adding(UInt32(activity.count))
            .adding(activity.flatMap(\.data))
            .adding(blocked.data)
            .adding(settings.data)
            .compressed
    }
    
    public init(data: inout Data) {
        data.decompress()
        counter = .init(data.uInt16())
        date = .init(timestamp: data.uInt32())
        pages = (0 ..< .init(data.uInt16()))
            .map { _ in
                .init(data: &data)
            }
        activity = (0 ..< .init(data.uInt32()))
            .map { _ in
                .init(timestamp: data.uInt32())
            }
        blocked = (0 ..< .init(data.uInt16()))
            .reduce(into: [:]) { result, _ in
                result[data.string()] = (0 ..< .init(data.uInt16()))
                    .map { _ in
                        .init(timestamp: data.uInt32())
                    }
            }
        settings = data.isEmpty ? .init() : .init(data: &data)
    }
    
    private init() {
        date = .init(timeIntervalSince1970: 0)
        pages = .init()
        activity = []
        blocked = [:]
        settings = .init()
    }
    
    mutating func browse(_ search: String) -> (id: Int, browse: Browse)? {
        search.browse(engine: settings.engine) {
            (add($0), $1)
        }
    }
    
    mutating func browse(_ id: Int, _ search: String) -> Browse? {
        search.browse(engine: settings.engine) {
            if let page = pages.remove(id: id)?.with(access: .remote($0)) {
                pages.append(page)
            } else {
                add($0)
            }
            return $1
        }
    }
    
    @discardableResult mutating func add(_ url: URL) -> Int {
        let id = counter
        pages.append(.init(id: id, access: .init(url: url)))
        counter += 1
        return id
    }
    
    @discardableResult private mutating func add(_ remote: String) -> Int {
        let id = counter
        pages.append(.init(id: id, access: .remote(remote)))
        counter += 1
        return id
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.date.timestamp == rhs.date.timestamp &&
            lhs.pages == rhs.pages &&
            lhs.activity == rhs.activity &&
            lhs.blocked == rhs.blocked
    }
}
