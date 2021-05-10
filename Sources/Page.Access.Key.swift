import Foundation

extension Page.Access {
    enum Key: UInt8 {
        case
        remote,
        local
    }
    
    var key: Key {
        switch self {
        case .remote: return .remote
        case .local: return .local
        }
    }
}
