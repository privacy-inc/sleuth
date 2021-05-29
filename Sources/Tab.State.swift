import Foundation

extension Tab {
    public enum State: Equatable {
        case
        new,
        browse(Int),
        error(Int, Error)
        
        public var browse: Int? {
            switch self {
            case let .browse(id), let .error(id, _):
                return id
            default:
                return nil
            }
        }
        
        public var isNew: Bool {
            switch self {
            case .new:
                return true
            default:
                return false
            }
        }
        
        public var isBrowse: Bool {
            switch self {
            case .browse:
                return true
            default:
                return false
            }
        }
        
        public var isError: Bool {
            switch self {
            case .error:
                return true
            default:
                return false
            }
        }
    }
}
