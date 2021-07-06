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
    
    func wildcard(level: Int) -> String {
        """
.wildcard(.init([
\(sorted()
    .map {
        level.indent + $0
    }
    .joined(separator: """
,

"""))]))
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
    
    mutating func chain(components: [String]) {
        components
            .last
            .map { key in
                { remain in
                    self[key] = remain.isEmpty
                        ? self[key] == nil
                            ? ".end"
                            : self[key]
                        : {
                            switch $0 {
                            case "*":
                                return Set<String>()
                            default:
                                return (self[key]
                                    .flatMap {
                                        $0 as? Self
                                    } ?? .init())
                                    .map {
                                        var previous = $0
                                        previous.chain(components: .init(remain))
                                        return previous
                                    }
                            }
                        } (remain.last!)
                } (components.dropLast())
            }
    }
    
    func previous(level: Int) -> String {
        """
.previous([
\(listed(level: level + 1))])
"""
    }
    
    private func listed(level: Int) -> String {
        """
\(sorted {
    $0.0 < $1.0
}
.destructure(level: level)
.joined(separator: """
,

"""))
"""
    }
}

private extension Array where Element == (key: String, value: Any) {
    func destructure(level: Int) -> [String] {
        map { (key: String, value: Any) in
            level.indent + key + " : " + destructure(level: level, value: value)
        }
    }
    
    private func destructure(level: Int, value: Any) -> String {
        switch value {
        case let dictionary as [String : Any]:
            return dictionary
                .previous(level: level)
        case let set as Set<String>:
            return set
                .wildcard(level: level)
        default:
            return value as! String
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
