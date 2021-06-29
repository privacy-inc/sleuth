import Foundation

extension Array where Element == Filtered {
    func filter(_ string: String) -> Self {
        string
            .isEmpty
            ? self
            : Set(self
                .filter {
                    $0.title.localizedCaseInsensitiveContains(string)
                        || $0.url.localizedCaseInsensitiveContains(string)
                })
            .sorted()
    }
}
