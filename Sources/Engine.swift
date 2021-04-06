import Foundation

public enum Engine: String {
    case
    ecosia,
    google
    
    public func browse(_ string: String) -> Browse? {
        string.trimmed {
            $0.url(transform: Browse.navigate)
                ?? $0.partialURL(transform: Browse.navigate)
                ?? $0.query { URL(string: prefix + $0).map(Browse.search) }
                ?? nil
        } ?? nil
    }
    
    private var prefix: String {
        switch self {
        case .ecosia: return "https://www.ecosia.org/search?q="
        case .google: return "https://www.google.com/search?q="
        }
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
    
    func query<T>(transform: (Self) -> T) -> T? {
        addingPercentEncoding(
            withAllowedCharacters:
                CharacterSet.urlQueryAllowed.subtracting(.init(arrayLiteral: "&", "+")))
            .map(transform)
    }
    
    private func separated<T>(transform: ([Self]) -> T) -> T {
        transform(components(separatedBy: "."))
    }
}
