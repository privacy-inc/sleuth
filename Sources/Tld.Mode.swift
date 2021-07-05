import Foundation

extension Tld {
    enum Mode {
        case
        previous([Tld : Mode]),
        exception,
        wildcard,
        end
    }
}
