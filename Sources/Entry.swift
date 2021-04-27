import Foundation
import Archivable

public struct Entry: Equatable, Property {
    public let title: String
    public let date: Date
    let id: Int
    let bookmark: Bookmark
    
    public var url: String {
        bookmark.url
    }
    
    public var data: Data {
        Data()
            .adding(UInt16(id))
            .adding(date)
            .adding(title)
            .adding(bookmark.data)
    }
    
    public init(data: inout Data) {
        id = .init(data.uInt16())
        date = data.date()
        title = data.string()
        bookmark = .init(data: &data)
    }
    
    init(id: Int, title: String, url: String) {
        self.id = id
        self.title = title
        bookmark = .init(url: url)
        date = .init()
    }
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.bookmark == rhs.bookmark &&
            lhs.date.timestamp == rhs.date.timestamp
    }
}
