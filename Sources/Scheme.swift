import Foundation

extension URL {
    enum Scheme: String {
        case
        https,
        http,
        data,
        file,
        privacy
        
        static let separator = "://"
        
        var url: String {
            rawValue + Self.separator
        }
    }
}
