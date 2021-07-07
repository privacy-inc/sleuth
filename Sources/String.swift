import Foundation

extension String {
    func components<Result>(transform: ([Self]) -> Result) -> Result {
        transform(replacingOccurrences(of: "https://", with: "")
                    .replacingOccurrences(of: "http://", with: "")
                    .components(separatedBy: "/")
                    .first!
                    .components(separatedBy: ":")
                    .first!
                    .components(separatedBy: "."))
    }
    
    func browse<Result>(engine: Engine, result: (Self) -> Result) -> Result? {
        trimmed {
            $0.url
                ?? $0.file
                ?? $0.partial
                ?? $0.query(engine)
        }
        .map(result)
    }
    
    private func trimmed(transform: (Self) -> Self?) -> Self? {
        {
            $0.isEmpty ? nil : transform($0)
        } (trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    private func query(_ engine: Engine) -> Self? {
        var components = URLComponents(string: "//www." + engine.url.rawValue + "." + engine.url.tld.rawValue)!
        components.scheme = "https"
        components.path = "/search"
        components.queryItems = [.init(name: "q", value: self)]
        return components.string
    }
    
    private var url: Self? {
        (.init(string: self)
            ?? addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union(.urlFragmentAllowed))
            .flatMap(URL.init(string:)))
                .flatMap {
                    $0.scheme != nil && ($0.host != nil || $0.query != nil)
                        ? $0.absoluteString
                        : nil
                }
    }
    
    private var file: Self? {
        {
            $0
                .flatMap {
                    $0.isFileURL ? self : nil
                }
        } (URL(string: self))
    }
    
    private var partial: Self? {
        {
            $0.count > 1
                && $0
                    .last
                    .flatMap {
                        Tld.suffix[$0]
                    } != nil
                && !$0.first!.isEmpty
                && !$0.first!.contains("/")
                && !contains(" ")
                ? URL.Scheme.https.rawValue + "://" + self
                : nil
        } (components(separatedBy: "."))
    }
}
