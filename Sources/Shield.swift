import Foundation

public struct Shield {
    public static func policy(for url: URL, shield: Bool) -> Policy {
        url.scheme.flatMap {
            Site.Ignore(rawValue: $0)
                .map { _ in
                    .ignore
                } ?? Scheme(rawValue: $0)
                    .map {
                        if shield {
                            if let schemeless = $0.schemeless(url) {
                                for site in Site.Partial.allCases {
                                    guard schemeless.contains(site.url) else { continue }
                                    return .block(site.url)
                                }
                                
                                let domain = schemeless.components(separatedBy: "/").first!
                                
                                for site in Site.Domain.allCases {
                                    guard domain.hasSuffix(site.rawValue) else { continue }
                                    return .block(domain)
                                }
                                
                                for item in domain.components(separatedBy: ".").dropLast() {
                                    guard Site.Component(rawValue: item) == nil else { return .block(domain) }
                                    continue
                                }
                            }
                        }
                        return .allow
                    }
        } ?? .external
    }
}
