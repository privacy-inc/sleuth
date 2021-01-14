import Foundation
import Combine

public final class Shield {
    private let queue = DispatchQueue(label: "", qos: .utility)
    
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
                                            if let web = $0.web(url) {
                                                let domain = web.components(separatedBy: "/").first!
                                                
                                                for site in Sites.Blacklist.allCases {
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
