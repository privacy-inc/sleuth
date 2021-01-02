import Foundation

public struct Page: Codable, Identifiable, Hashable {
    public var url: URL
    public var date: Date
    public var title: String
    public let id: UUID
    
    public var shared: Share.Page {
        .init(url: URL(string: Scheme.privacy_id.url + id.uuidString)!, title: title, subtitle: url.absoluteString)
    }
    
    public init(url: URL) {
        id = .init()
        date = .init()
        title = ""
        self.url = url
    }
    
    public func hash(into: inout Hasher) {
        into.combine(id)
        into.combine(url)
        into.combine(title)
        into.combine(date)
    }
    
    public static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
            && lhs.url == rhs.url
            && lhs.title == rhs.title
            && lhs.date == rhs.date
    }
}
