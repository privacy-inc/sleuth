import Foundation

extension Router {
    public enum Direction {
        case
        allow,
        ignore,
        external,
        block(String)
    }
}
