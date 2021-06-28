import Foundation

extension Array where Element == Page {
    public func filter(_ string: String) -> [Filtered] {
        .init(map(Filtered.init(page:))
                .filter(string)
                .prefix(2))
    }
}
