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
                        .map { (subdomain: String) -> Policy in
                            .block(subdomain + "." + white.rawValue)
                        }
                    ?? path
                        .map { (path: String) -> Policy in
                            white
                                .path
                                .map(\.rawValue)
                                .contains(path) ? .block(white.rawValue + "." + white.tld.rawValue + "/" + path) : .allow
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
