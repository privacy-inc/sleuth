import Foundation

public enum Tab {
    case
    new,
    history(Int),
    error(Int, Error)
}
