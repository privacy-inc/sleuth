import Foundation

extension Array where Element == Filtered {
    func filter(_ string: String) -> Self {
        string
            .isEmpty
            ? self
            : Set({ components in
                self
                    .filter {
                        $0.contains(components)
                    }
            } (string.components(separatedBy: " ")))
            .sorted()
    }
}
