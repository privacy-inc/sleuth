import Foundation

public extension Engine {
    enum Browse {
        case
        search(String),
        navigate(String)
        
        public var url: String {
            switch self {
            case let .search(url), let .navigate(url):
                return url
            }
        }
    }
}
