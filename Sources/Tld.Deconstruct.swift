import Foundation

extension Tld {
    static func deconstruct(url: String) -> (domain: String, suffix: String) {
        {
            (domain: $0.domain ?? "", suffix: ($0.suffix.isEmpty ? "" : ".") + $0.suffix.joined(separator: "."))
        } (url
            .components(separatedBy: ".")
            .reversed()
            .reduce(into: (
                        domain: nil as String?,
                        suffix: [String](),
                        next: Self.suffix as [Tld : Tld.Mode]?,
                        exceptions: nil as Set<Tld>?))
            { result, component in
                guard let mode = result.next?[component] else {
                    if result.domain == nil {
                        if let exceptions = result.exceptions {
                            if let tld = Tld(rawValue: component), exceptions.contains(tld) {
                                result.domain = component
                            } else {
                                result.suffix.insert(component, at: 0)
                                result.exceptions = nil
                            }
                        } else {
                            result.domain = component
                        }
                    }
                    return
                }
                switch mode {
                case let .previous(previous):
                    result.suffix.insert(component, at: 0)
                    result.next = previous
                case let .wildcard(wildcard):
                    result.suffix.insert(component, at: 0)
                    result.next = nil
                    result.exceptions = wildcard
                case .end:
                    result.suffix.insert(component, at: 0)
                    result.next = nil
                }
            })
    }
    
    private func deconstruct(components: [String]) -> (domain: String?, suffix: [String]) {
        return (nil, [])
    }
}
