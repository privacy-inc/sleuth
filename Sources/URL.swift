import Foundation

public extension URL {
    var deeplink: Bool {
        switch scheme {
        case nil, "": return false
        case Scheme.http.rawValue: return false
        case Scheme.https.rawValue: return false
        default: return true
        }
    }
}
