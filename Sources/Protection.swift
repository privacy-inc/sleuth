import Foundation

public protocol Protection {
    func policy(for url: URL) -> Policy
}

public struct Antitracker: Protection {
    public init() { }
    
    public func policy(for url: URL) -> Policy {
        scheme(for: url) { _ in
            if let domain = url.host {
                for site in Site.Domain.allCases {
                    guard domain.hasSuffix(site.rawValue) else { continue }
                    return .block(domain)
                }
                
                for site in Site.Partial.allCases {
                    guard
                        domain.hasSuffix(site.domain.rawValue),
                        url.path.hasPrefix(site.rawValue)
                    else { continue }
                    return .block(site.url)
                }
                
                for item in domain.components(separatedBy: ".").dropLast() {
                    guard Site.Component(rawValue: item) == nil else { return .block(domain) }
                    continue
                }
            }
            
            return .allow
        }
    }
}

public struct Simple: Protection {
    public init() { }
    
    public func policy(for url: URL) -> Policy {
        scheme(for: url) { _ in
            .allow
        }
    }
}

private extension Protection {
    func scheme(for url: URL, transform: (Scheme) -> Policy) -> Policy {
        url.scheme.flatMap {
            Site.Ignore(rawValue: $0)
                .map { _ in
                    .ignore
                } ?? Scheme(rawValue: $0)
                        .map(transform)
        } ?? .external
    }
}
