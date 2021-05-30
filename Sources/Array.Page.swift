import Foundation

extension Array where Element == Page {
    public func filter(_ string: String) -> [Filtered] {
        .init(Set(filter {
            $0.title.localizedCaseInsensitiveContains(string)
                || $0.access.string.localizedCaseInsensitiveContains(string)
        }
        .map(Filtered.init(page:)))
        .sorted()
        .prefix(2))
    }
}
