import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public internal(set) var date: Date
    public internal(set) var pages: [Page]
    public internal(set) var activity: [Date]
    public internal(set) var blocked: [String: Date]
    
    public var data: Data {
        Data()
            .adding(date.timestamp)
            .adding(UInt16(pages.count))
            .adding(pages.flatMap(\.data))
            .adding(UInt32(activity.count))
            .adding(activity.flatMap {
                Data()
                    .adding($0.timestamp)
            })
    }
    
    public init(data: inout Data) {
        date = .init(timestamp: data.uInt32())
        pages = (0 ..< .init(data.uInt16())).map { _ in
            .init(data: &data)
        }
        activity = (0 ..< .init(data.uInt32())).map { _ in
            .init(timestamp: data.uInt32())
        }
        blocked = [:]
    }
    
    private init() {
        date = .init(timeIntervalSince1970: 0)
        pages = .init()
        activity = []
        blocked = [:]
    }
    
    public mutating func add(_ page: inout Page) {
        page.date = .init()
        pages.removeAll { $0.id == page.id }
        pages.insert(page, at: 0)
        save()
    }
    
    public mutating func remove(_ page: Page) {
        pages.removeAll { $0.id == page.id }
        save()
    }
    
    private mutating func save() {
        date = .init()
        Repository.save(self)
    }
}
