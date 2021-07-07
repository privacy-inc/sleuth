import Foundation

extension Tld {
    static func deconstruct(url: String) -> (domain: String, suffix: String) {
        url
            .components {
                var components = $0
                var suffix = [String]()
                var domain = ""
                var next = components
                    .popLast()
                var context: [Tld : Tld.Mode]?
                
                while next != nil {
                    var mode: Tld.Mode?
                    if context == nil {
                        mode = Tld.suffix[next!]
                    } else {
                        mode = context![next!]
                    }
                    
                    switch mode {
                    case let .previous(previous):
                        context = previous
                        suffix.insert(next!, at: 0)
                        next = components
                            .popLast()
                    case let .wildcard(wildcard):
                        suffix.insert(next!, at: 0)
                        components
                            .popLast()
                            .map {
                                if wildcard.contains($0) {
                                    domain = $0
                                } else {
                                    suffix.insert($0, at: 0)
                                    components
                                        .last
                                        .map {
                                            domain = $0
                                        }
                                }
                            }
                        next = nil
                    case .end:
                        suffix.insert(next!, at: 0)
                        components
                            .last
                            .map {
                                domain = $0
                            }
                        next = nil
                        break
                    case nil:
                        domain = next!
                        next = nil
                    }
                }
                
                return (domain: domain, suffix: suffix.isEmpty
                            ? ""
                            : "." + suffix.joined(separator: "."))
            }
    }
}
