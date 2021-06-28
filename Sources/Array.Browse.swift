import Foundation

extension Array where Element == Browse {
    public func filter(_ string: String) -> [Filtered] {
        .init(map(\.page)
                .map(Filtered.init(page:))
                .filter(string)
                .prefix(3))
    }
}
