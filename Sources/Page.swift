import Foundation
import Archivable

public struct Page: Equatable, Property {
    public let id: Int
    public let title: String
    public let date: Date
    let access: Access
    
    public var subtitle: String {
        access.subtitle
    }
    
    public var url: URL {
        access.url
    }
    
    public var data: Data {
        Data()
            .adding(UInt16(id))
            .adding(date)
            .adding(title)
            .adding(access.data)
    }
    
    public init(data: inout Data) {
        id = .init(data.uInt16())
        date = data.date()
        title = data.string()
        access = .init(data: &data)
    }
    
    init(id: Int, title: String = "", access: Access, date: Date = .init()) {
        self.id = id
        self.title = title
        self.access = access
        self.date = date
    }
    
    var revisit: Self {
        .init(id: id, title: title, access: access, date: .init())
    }
    
    func with(title: String) -> Self {
        .init(id: id, title: title, access: access, date: .init())
    }
    
    func with(url: URL) -> Self {
        .init(id: id, title: title, access: .init(url: url), date: .init())
    }
    
    func with(access: Access) -> Self {
        .init(id: id, title: title, access: access, date: .init())
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.access == rhs.access &&
            lhs.date.timestamp == rhs.date.timestamp
    }
}
