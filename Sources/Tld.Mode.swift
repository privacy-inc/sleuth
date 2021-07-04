import Foundation

extension Tld {
    public enum Mode {
        case
        previous([Tld : Mode]),
        exception,
        wildcard,
        end
    }
}
