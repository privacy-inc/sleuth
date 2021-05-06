import Foundation

extension URL {
    enum Scheme: String {
        case
        https,
        http
        
        static let separator = "://"
        
        var url: String {
            rawValue + Self.separator
        }
    }
}
