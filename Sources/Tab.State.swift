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
    }
}
