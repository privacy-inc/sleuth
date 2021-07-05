import Foundation

enum TldParser {
    static func parse(content: String) -> (enum: String, suffix: String) {
        {
            ($0.set.serial, $0.dictionary.serial)
        } (content
            .lines
            .reduce(into: (set: Set<String>(), dictionary: [String : [Any]]())) { _, _ in
            })
    }
}

private extension String {
    var lines: [[String]] {
        trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter {
                !$0.isEmpty
            }
            .filter {
                $0.first != "/"
            }
            .map {
                $0.components(separatedBy: ".")
            }
    }
}

private extension Set where Element == String {
    var serial: String {
        """
import Foundation

public enum Tld: String {
    case
}

"""
    }
}

private extension Dictionary where Key == String, Value == [Any] {
    var serial: String {
        """
import Foundation

extension Tld {
    static let suffix: [Tld : Mode] = [
        ]
}

"""
    }
}
