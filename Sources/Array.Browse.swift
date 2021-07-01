import Foundation

extension Array where Element == Browse {
    public func filter(_ string: String) -> [Filtered] {
        .init(map(\.page)[string]
                .prefix(3))
    }
}
