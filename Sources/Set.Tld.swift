import Foundation

extension Set where Element == Tld {
    func contains(_ string: String) -> Bool {
        Tld(rawValue: string)
            .flatMap {
                contains($0)
            } ?? false
    }
}
