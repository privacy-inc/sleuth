import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public var date: Date
    public internal(set) var settings: Settings
    public internal(set) var browse: [Browse]
    public internal(set) var bookmarks: [Page]
    public internal(set) var activity: [Date]
    public internal(set) var blocked: [String: [Date]]
    var counter = 0
    
    public var data: Data {
        Data()
            .adding(UInt16(counter))
            .adding(date)
            .adding(UInt16(browse.count))
            .adding(browse.flatMap(\.data))
            .adding(UInt32(activity.count))
            .adding(activity.flatMap(\.data))
            .adding(blocked.data)
            .adding(settings.data)
            .adding(UInt16(bookmarks.count))
            .adding(bookmarks.flatMap(\.data))
            .compressed
    }
    
    public init(data: inout Data) {
        data.decompress()
        counter = .init(data.uInt16())
        date = .init(timestamp: data.uInt32())
        browse = (0 ..< .init(data.uInt16()))
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
        bookmarks = (0 ..< (data.isEmpty ? 0 : .init(data.uInt16())))
            .map { _ in
                .init(data: &data)
            }
    }
    
    private init() {
        date = .init(timeIntervalSince1970: 0)
        browse = .init()
        activity = []
        blocked = [:]
        settings = .init()
        bookmarks = []
    }
    
    public func page(_ id: Int) -> Page {
        browse
            .first {
                $0.id == id
            }
            .map(\.page)
            ?? .blank
    }
    
    mutating func browse(_ search: String, id: Int?) -> Int? {
        search.browse(engine: settings.engine) {
            update(id, .remote($0)) ?? add(.remote($0))
        }
    }
    
    mutating func add(_ access: Page.Access) -> Int {
        let id = counter
        browse.insert(.init(id: id, page: .init(access: access)), at: 0)
        counter += 1
        return id
    }
    
    mutating func update(_ id: Int?, _ access: Page.Access) -> Int? {
        guard
            let id = id,
            let page = browse.remove(where: { $0.id == id })?.with(access: access)
        else { return nil }
        browse.insert(page, at: 0)
        return id
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.date.timestamp == rhs.date.timestamp
            && lhs.browse == rhs.browse
            && lhs.activity == rhs.activity
            && lhs.blocked == rhs.blocked
            && lhs.settings == rhs.settings
            && lhs.bookmarks == rhs.bookmarks
    }
}
