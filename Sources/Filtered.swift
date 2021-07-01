import Foundation

public struct Filtered: Hashable, Comparable {
    public var domain: String {
        url.domain
    }
    
    public let title: String
    public let url: String
    let matches: Int
    
    init(page: Page, matches: Int) {
        title = page.title
        url = page.access.string
        self.matches = matches
    }
    
    public func hash(into: inout Hasher) {
        into.combine(url.lowercased())
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.url.localizedCaseInsensitiveCompare(rhs.url) == .orderedSame
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.matches > rhs.matches
            ? true
            : lhs.matches < rhs.matches
                ? false
                : lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
    }
}
