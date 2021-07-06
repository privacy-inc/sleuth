import Foundation

extension Tld {
    enum Mode {
        case
        previous([Tld : Mode]),
        wildcard(Set<Tld>),
        end
    }
}
