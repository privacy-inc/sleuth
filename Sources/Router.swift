import Foundation

public class Router {
    public static let secure: Router = Secure()
    public static let regular = Router()
    
    init() { }
    
    public final func callAsFunction(_ url: URL) -> Policy {
        url
            .scheme
            .map {
                URL.Embed(rawValue: $0)
                    .map(\.policy)
                ?? URL.Scheme(rawValue: $0)
                    .map { _ in
                        url
                            .host
                            .map {
                                (Array($0
                                        .components(separatedBy: ".")
                                        .dropLast()),
                                 url
                                    .path
                                    .components(separatedBy: "/")
                                    .dropFirst()
                                    .first)
                            }
                            .map {
                                !$0.0.isEmpty
                                    ? route(host: $0.0, path: $0.1)
                                    : .ignore
                            }
                        ?? .ignore
                    }
                ?? .external
            }
            ?? .ignore
    }
    
    func route(host: [String], path: String?) -> Policy {
        .allow
    }
}
