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
    
    func contains(_ strings: [String]) -> Bool {
        strings
            .first {
                title.localizedCaseInsensitiveContains($0)
                    || url.localizedCaseInsensitiveContains($0)
            } != nil
    }
    
    public func hash(into: inout Hasher) {
        into.combine(url)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.url.localizedCaseInsensitiveCompare(rhs.url) == .orderedSame
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
    }
}
