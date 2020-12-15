import Foundation

public final class Page: Codable, Identifiable, Hashable {
    public var url: URL
    public var date: Date
    public var title: String
    public let id: UUID
    
    public init(url: URL) {
        id = .init()
        date = .init()
        title = ""
        self.url = url
    }
    
    public func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    public static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }
}
