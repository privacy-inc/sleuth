import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public var date: Date
    public internal(set) var settings: Settings
    public internal(set) var browse: [Browse]
    public internal(set) var bookmarks: [Page]
    var blocked: [String: [Date]]
    var activity: [Date]
    var counter = 0
    
    public var since: Date? {
        activity
            .first
    }
    
    public var plotter: [Double] {
        activity
            .map(\.timeIntervalSince1970)
            .plotter
    }
    
    public var trackers: [(name: String, count: [Date])] {
        blocked
            .sorted {
                $0.1.count == $1.1.count
                    ? $0.0.localizedCaseInsensitiveCompare($1.0) == .orderedAscending
                    : $0.1.count > $1.1.count
            }
            .map {
                (name: $0.key, count: $0.value)
            }
    }
    
    public var data: Data {
        Data()
            .adding(UInt16(counter))
            .adding(date)
            .adding(UInt16(browse.count))
            .adding(browse.flatMap(\.data))
            .adding(UInt32(activity.count))
            .adding(activity.flatMap(\.data))
            .adding(blocked.data)
            .adding(settings.pre)
            .adding(UInt16(bookmarks.count))
            .adding(bookmarks.flatMap(\.data))
            .adding(settings.post)
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
        if !data.isEmpty {
            let pre = data.prefix(10)
            data.removeFirst(10)
            bookmarks = (0 ..< (data.isEmpty ? 0 : .init(data.uInt16())))
                .map { _ in
                    .init(data: &data)
                }
            data = pre + data
            settings = .init(data: &data)
        } else {
            settings = .init()
            bookmarks = []
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
    
    mutating func browse(_ search: String, id: Int?) -> (id: Int, access: Page.Access)? {
        search.browse(engine: settings.engine) {
            {
                {
                    (id: update(id, $0) ?? add($0), access: $0)
                } ($0)
            } (.remote($0))
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
