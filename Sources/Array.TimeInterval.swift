import Foundation

private let divisions = 10

extension Array where Element == TimeInterval {
    var plotter: [Double] {
        guard let first = self.first else { return [] }
        let interval = (Date().timeIntervalSince1970 - first) / .init(divisions)
        let ranges = (0 ..< divisions).map {
            (.init($0) * interval) + first
        }
        var index = 0
        let array = reduce(into: Array(repeating: .init(), count: divisions)) {
            while index < divisions - 1 && ranges[index + 1] < $1 {
                index += 1
            }
            $0[index] += 1
        }
        let top = array.max()!
        return array.map { $0 / top }
    }
}
