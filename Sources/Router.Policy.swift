import Foundation

extension Router {
    public enum Policy {
        case
        allow,
        ignore,
        external,
        block(String)
    }
}
