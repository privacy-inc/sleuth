import Foundation

public class Router {
    public static let secure: Router = Secure()
    public static let regular = Router()
    
    init() { }
    
    public final func callAsFunction(_ url: URL) -> Direction {
        url
            .scheme
            .flatMap {
                URL.Ignore(rawValue: $0)
                    .map { _ in
                        .ignore
                    }
                ?? URL.Scheme(rawValue: $0)
                    .map { _ in
                        direct(url)
                    }
                ?? .external
            }
            ?? .ignore
    }
    
    func direct(_ url: URL) -> Direction {
        .allow
    }
}
