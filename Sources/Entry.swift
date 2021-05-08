import Foundation
import Archivable

public struct Entry: Equatable, Property {
    public let id: Int
    public let title: String
    public let date: Date
    let bookmark: Bookmark
    
    public var url: String {
        bookmark.url
    }
    
    public var access: URL? {
        bookmark.access
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
    
    init(id: Int, title: String = "", bookmark: Bookmark, date: Date = .init()) {
        self.id = id
        self.title = title
        self.bookmark = bookmark
        self.date = date
    }
    
    var revisit: Self {
        .init(id: id, title: title, bookmark: bookmark, date: .init())
    }
    
    func with(title: String) -> Self {
        .init(id: id, title: title, bookmark: bookmark, date: .init())
    }
    
    func with(url: URL) -> Self {
        .init(id: id, title: title, bookmark: .init(url: url), date: .init())
    }
    
    func with(bookmark: Bookmark) -> Self {
        .init(id: id, title: title, bookmark: bookmark, date: .init())
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.bookmark == rhs.bookmark &&
            lhs.date.timestamp == rhs.date.timestamp
    }
}
