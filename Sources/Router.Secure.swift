import Foundation

extension Router {
    final class Secure: Router {
        override func route(host: [String], path: String?) -> Policy {
            URL
                .White
                .init(rawValue: host.last!)
                .map { white in
                    white
                        .subdomain
                        .map(\.rawValue)
                        .intersection(other: host
                                        .dropLast())
                        .first
                        .map(Policy.block)
                    ?? path
                        .map {
                            white
                                .path
                                .map(\.rawValue)
                                .contains($0) ? .block(white.rawValue) : .allow
                        }
                    ?? .allow
                }
            ?? URL
                .Black
                .init(rawValue: host.last!)
                .map(\.rawValue)
                .map(Policy.block)
            ?? host
                .dropLast()
                .compactMap(URL.Subdomain.init(rawValue:))
                .map(\.rawValue)
                .first
                .map(Policy.block)
            ?? .allow
        }
    }
}
