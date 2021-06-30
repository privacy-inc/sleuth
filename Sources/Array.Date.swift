import Foundation

extension Array where Element == Date {
    public var plotter: [Double] {
        map(\.timeIntervalSince1970)
            .plotter
    }
}
