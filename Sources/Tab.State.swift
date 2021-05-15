import Foundation

extension Tab {
    public enum State {
        case
        new,
        browse(Int),
        error(Int, WebError)
    }
}
