import Foundation

extension Tab {
    public enum State {
        case
        new,
        history(Int),
        error(Int, Error)
    }
}
