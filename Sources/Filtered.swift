import Foundation

public struct Filtered: Hashable, Comparable {
    public let title: String
    public let url: String
    public var domain: String {
        url.domain
    }
    
    init(page: Page) {
        title = page.title
        url = page.access.string
    }
    
    public func hash(into: inout Hasher) {
        into.combine(url)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.url == rhs.url
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
    }
}
