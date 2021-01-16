import Foundation
import Combine

public final class Shield {
    private let queue = DispatchQueue(label: "", qos: .utility, attributes: .concurrent)
    
    public init() { }
    
    public func policy(for url: URL, shield: Bool) -> Future<Policy, Never> {
        .init { [weak self] result in
            self?.queue.async {
                result(.success(
                        url.scheme.flatMap {
                            Ignore(rawValue: $0)
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
                                                    guard Component(rawValue: item) == nil else { return .block(domain) }
                                                    continue
                                                }
                                            }
                                        }
                                        return .allow
                                    }
                        } ?? .external))
            }
        }
    }
}
