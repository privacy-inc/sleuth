import Foundation

extension Array where Element == Page {
    public func filter(_ string: String) -> [Filtered] {
        {
            {
                .init($0
                        .prefix(2))
            } (string
                .isEmpty
                ? $0
                : $0
                .filter {
                    $0.title.localizedCaseInsensitiveContains(string)
                        || $0.url.localizedCaseInsensitiveContains(string)
                }
                .sorted())
        } (map(Filtered.init(page:)))
    }
}
