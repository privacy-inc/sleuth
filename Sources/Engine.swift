import Foundation

public enum Engine: String {
    case
    ecosia,
    google
    
    public func browse(_ string: String) -> Browse? {
        string.trimmed {
            $0.url(transform: Browse.navigate)
                ?? $0.partialURL(transform: Browse.navigate)
                ?? query(string)
                        .map(Browse.search)
        } ?? nil
    }
    
    private var prefix: String {
        switch self {
        case .ecosia: return "https://www.ecosia.org"
        case .google: return "https://www.google.com"
        }
    }
    
    private var path: String {
        "/search"
    }
    
    private var query: String {
        "q"
    }
    
    private func query(_ value: String) -> URL? {
        var components = URLComponents(string: prefix)!
        components.path = path
        components.queryItems = [.init(name: query, value: value)]
        return components.url
    }
}

private extension String {
    func trimmed<T>(transform: (Self) -> T) -> T? {
        {
            $0.isEmpty ? nil : transform($0)
        } (trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func url<T>(transform: (URL) -> T) -> T? {
        isEmpty ? nil : URL(string: self).flatMap {
            $0.scheme == nil ? nil : transform($0)
        }
    }
    
    func partialURL<T>(transform: (URL) -> T) -> T? {
        separated {
            $0.count > 1 && $0.last!.count > 1 && $0.first!.count > 1 ? URL(string: Scheme.https.url + self).map(transform) : nil
        }
    }
    
    private func separated<T>(transform: ([Self]) -> T) -> T {
        transform(components(separatedBy: "."))
    }
}
