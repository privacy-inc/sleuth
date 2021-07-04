import Foundation

extension Tld {
    public enum Mode {
        case
        previous([Tld]),
        exception,
        wildcard,
        end
    }
}
