import Foundation

extension Array where Element == Page {
    public func filter(_ string: String) -> [Filtered] {
        .init(self[string]
                .prefix(2))
    }
    
    subscript(_ string: String) -> [Filtered] {
        string
            .isEmpty
            ? map {
                .init(page: $0, matches: 0)
            }
            : Set({ components in
                map {
                    (page: $0, matches: $0
                        .matches(components))
                }
                .filter {
                    $0.matches > 0
                }
                .map {
                    .init(page: $0.page, matches: $0.matches)
                }
            } (string.components(separatedBy: " ")))
            .sorted()
    }
}
