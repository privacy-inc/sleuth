import Foundation

extension Dictionary where Key == Tld, Value == Tld.Mode {
    subscript(_ string: String) -> Tld.Mode? {
        Tld(rawValue: string)
            .flatMap {
                self[$0]
            }
    }
}
