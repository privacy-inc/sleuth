import Foundation

extension Router {
    final class Secure: Router {
        override func direct(_ url: URL) -> Direction {
            if let domain = url.host {
                let components = domain.components(separatedBy: ".").dropLast()
                let rejoined = components.joined(separator: ".")
                for black in URL.Black.allCases {
                    guard rejoined.hasSuffix(black.rawValue) else { continue }
                    return .block(black.rawValue)
                }
                
                if let path = url.path.components(separatedBy: "/").dropFirst().first {
                    for black in URL
                        .White
                        .allCases
                        .map({
                            ($0.rawValue, $0
                                .black
                                .map(\.rawValue))
                        })
                        .filter({
                            !$0.1.isEmpty
                        }) {
                            guard
                                domain.hasSuffix(black.0),
                                black.1.contains(path)
                            else { continue }
                            return .block(black.0 + "/" + path)
                        }
                }
                
                for item in components {
                    guard URL.Subdomain(rawValue: item) == nil else {
                        return .block(domain)
                    }
                    continue
                }
            }
            return .allow
        }
    }
}
