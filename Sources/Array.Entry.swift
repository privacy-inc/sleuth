import Foundation

extension Array where Element == Entry {
    @discardableResult mutating func remove(id: Int) -> Element? {
        firstIndex {
            $0.id == id
        }
        .map {
            remove(at: $0)
        }
    }
}