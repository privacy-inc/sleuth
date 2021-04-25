import Foundation
import Archivable

public struct Archive: Archived {
    public static let new = Self()
    public internal(set) var date: Date
    public internal(set) var pages: [Page]
    public internal(set) var activity: [Date]
    public internal(set) var
    
    public var data: Data {
        Data()
            .adding(date.timestamp)
            .adding(UInt16(pages.count))
            .adding(pages.flatMap(\.data))
    }
    
    public init(data: inout Data) {
        date = .init(timestamp: data.uInt32())
        pages = (0 ..< .init(data.uInt16())).map { _ in
            .init(data: &data)
        }
    }
    
    private init() {
        date = .init(timeIntervalSince1970: 0)
        pages = .init()
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
