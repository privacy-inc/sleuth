import Foundation

public extension URL {
    var deeplink: Bool {
        switch scheme {
        case nil, "", "http", "https": return false
        default: return true
        }
    }
}
