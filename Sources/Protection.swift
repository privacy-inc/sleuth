import Foundation

public enum Protection {
    case
    simple,
    antitracker
    
    public func policy(for url: URL) -> Policy {
        url.scheme.flatMap {
            Site.Ignore(rawValue: $0)
                .map { _ in
                    .ignore
                } ?? Scheme(rawValue: $0)
                    .map { _ in
                        switch self {
                        case .antitracker:
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
                        default: break
                        }
                        return .allow
                    }
        } ?? .external
    }
}
