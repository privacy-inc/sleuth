import Foundation

public struct Filtered: Hashable, Comparable {
    public let title: String
    public let domain: String
    let url: String
    
    init(page: Page) {
        title = page.title
        url = page.access.string
        domain = url.domain
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
    }
}
