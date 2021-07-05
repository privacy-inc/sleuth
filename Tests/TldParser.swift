import Foundation

enum TldParser {
    static func parse(content: String) -> (enum: String, suffix: String) {
        {
            ($0.set.serial, $0.dictionary.serial)
        } (content
            .lines
            .reduce(into: (set: Set<String>(), dictionary: [String : Any]())) { result, components in
                components
                    .filter {
                        $0 != "*"
                    }
                    .map {
                        $0.first == "!"
                            ? .init($0.dropFirst())
                            : $0
                    }
                    .filter {
                        !result
                            .set
                            .contains($0)
                    }
                    .forEach {
                        result
                            .set
                            .insert($0)
                    }
                
                result
                    .dictionary
                    .chain(components: components)
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
    \(sorted()
        .joined(separator: """
,
    \

"""))
}

"""
    }
}

private extension Dictionary where Key == String, Value == Any {
    var serial: String {
        """
import Foundation

extension Tld {
    static let suffix: [Tld : Mode] = [
\(listed(level: 1))]
}

"""
    }
    
    private func listed(level: Int) -> String {
        """
\(sorted {
    $0.0 < $1.0
}
.map { (key: String, value: Any) in
    level.indent + key + " : " + (value is Self
        ? """
.previous([
\((value as! Self)
    .listed(level: level + 1))])
"""
        : value as! String)
}
.joined(separator: """
,

"""))
"""
    }
    
    mutating func chain(components: [String]) {
        components
            .last
            .map { key in
                { remain in
                    self[key] = remain.isEmpty
                        ? self[key] == nil
                            ? ".end"
                            : self[key]
                        : (self[key]
                            .flatMap {
                                $0 as? Self
                            } ?? .init())
                            .map {
                                var previous = $0
                                previous.chain(components: .init(remain))
                                return previous
                            }
                } (components.dropLast())
            }
    }
}

private extension Int {
    var indent: String {
        (0 ... self)
            .flatMap { _ in
                "    "
            } + "."
    }
}
