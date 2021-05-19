import Foundation

extension Tab {
    public enum State {
        case
        new,
        browse(Int),
        error(Int, WebError)
        
        public var id: Int? {
            switch self {
            case let .browse(id), let .error(id, _):
                return id
            default:
                return nil
            }
        }
    }
}
