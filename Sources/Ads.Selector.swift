import Foundation

extension Ads {
    enum Selector {
        case
        id(String),
        contains(String),
        equals(String)
        
        var serialise: String {
            switch self {
            case let .id(value): return "id='\(value)'"
            case let .contains(value): return "class*='\(value)'"
            case let .equals(value): return "class='\(value)'"
            }
        }
    }
}
