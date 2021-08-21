import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public var timestamp: UInt32
    public internal(set) var settings: Settings
    public internal(set) var browses: [Browse]
    public internal(set) var bookmarks: [Page]
    public internal(set) var activity: [Date]
    var blocked: [String: [Date]]
    var counter = 0
    
    public var trackers: (count: Int, attempts: Int) {
        (count: blocked.count, attempts: blocked
            .map(\.1.count)
            .reduce(0, +))
    }
    
    public var data: Data {
        Data()
            .adding(UInt16(counter))
            .adding(timestamp)
            .adding(UInt16(browses.count))
            .adding(browses.flatMap(\.data))
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
        timestamp = data.uInt32()
        browses = (0 ..< .init(data.uInt16()))
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
        let pre = data.prefix(10)
        data.removeFirst(10)
        bookmarks = (0 ..< (data.isEmpty ? 0 : .init(data.uInt16())))
            .map { _ in
                .init(data: &data)
            }
        data = pre + data
        settings = .init(data: &data)
    }
    
    private init() {
        timestamp = 0
        browses = .init()
        activity = []
        blocked = [:]
        settings = .init()
        bookmarks = []
    }
    
    public func page(_ browse: Int) -> Page {
        browses
            .first {
                $0.id == browse
            }
            .map(\.page)
            ?? .blank
    }
    
    public func trackers(_ sorted: Trackers) -> [(name: String, count: [Date])] {
        sorted
            .sort(blocked)
            .map {
                (name: $0.key, count: $0.value)
            }
    }
    
    mutating func browse(_ search: String, browse: Int?) -> (browse: Int, access: Page.Access)? {
        search.browse(engine: settings.engine) {
            {
                {
                    (browse: update(browse, $0) ?? add($0), access: $0)
                } ($0)
            } (.remote(.init(value: $0)))
        }
    }
    
    mutating func add(_ access: Page.Access) -> Int {
        let id = counter
        browses.insert(.init(id: id, page: .init(access: access)), at: 0)
        counter += 1
        return id
    }
    
    mutating func update(_ browse: Int?, _ access: Page.Access) -> Int? {
        guard
            let browse = browse,
            let page = browses.remove(where: { $0.id == browse })?.with(access: access)
        else { return nil }
        browses.insert(page, at: 0)
        return browse
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.timestamp == rhs.timestamp
            && lhs.browses == rhs.browses
            && lhs.activity == rhs.activity
            && lhs.blocked == rhs.blocked
            && lhs.settings == rhs.settings
            && lhs.bookmarks == rhs.bookmarks
    }
}
