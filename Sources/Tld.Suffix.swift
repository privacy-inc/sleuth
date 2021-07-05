import Foundation

extension Tld {
    static let suffix: [Tld : Mode] = [
        .com : .end,
        .mx : .previous([
            .com : .end])]
}
