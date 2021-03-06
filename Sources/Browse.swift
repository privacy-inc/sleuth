import Foundation
import Archivable

public struct Browse: Hashable, Property {
    public let id: Int
    public let date: Date
    public let page: Page
    
    public var data: Data {
        Data()
            .adding(UInt16(id))
            .adding(date)
            .adding(page.data)
    }
    
    public init(data: inout Data) {
        id = .init(data.uInt16())
        date = data.date()
        page = .init(data: &data)
    }
    
    init(id: Int, page: Page, date: Date = .init()) {
        self.id = id
        self.page = page
        self.date = date
    }
    
    var revisit: Self {
        .init(id: id, page: page, date: .init())
    }
    
    func with(title: String) -> Self {
        .init(id: id, page: page.with(title: title), date: .init())
    }
    
    func with(access: Page.Access) -> Self {
        .init(id: id, page: page.with(access: access), date: .init())
    }
    
    public func hash(into: inout Hasher) {
        into.combine(id)
        into.combine(page)
        into.combine(date.timestamp)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.page == rhs.page &&
            lhs.date.timestamp == rhs.date.timestamp
    }
}
