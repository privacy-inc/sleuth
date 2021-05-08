import Foundation
import Archivable

public enum Engine: UInt8, Property {
    case
    ecosia,
    google
    
    public var data: Data {
        Data()
            .adding(rawValue)
    }
    
    public init(data: inout Data) {
        self.init(rawValue: data.removeFirst())!
    }
    
    func browse(_ string: String) -> Browse? {
        string.trimmed {
            $0.url(transform: Browse.navigate)
                ?? $0.partialURL(transform: Browse.navigate)
                ?? $0.query
                        .map {
                            prefix + $0
                        }
                        .map(Browse.search)
        }
    }
    
    private var prefix: String {
        switch self {
        case .ecosia: return "https://www.ecosia.org/search?q="
        case .google: return "https://www.google.com/search?q="
        }
    }
}

private extension String {
    func trimmed(transform: (Self) -> Browse?) -> Browse? {
        {
            $0.isEmpty ? nil : transform($0)
        } (trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func url(transform: (String) -> Browse) -> Browse? {
        isEmpty
            ? nil
            : URL(string: self)
                .flatMap {
                    $0.scheme == nil || ($0.host == nil && $0.query == nil)
                        ? nil
                        : transform($0.absoluteString)
                }
    }
    
    func partialURL(transform: (String) -> Browse) -> Browse? {
        separated {
            $0.count > 1 && $0.last!.count > 1 && $0.first!.count > 1
                ? URL(string: URL.Scheme.https.rawValue + "://" + self)
                    .map(\.absoluteString)
                    .map(transform)
                : nil
        }
    }
    
    var query: Self? {
        addingPercentEncoding(withAllowedCharacters:
                                .urlQueryAllowed
                                .subtracting(.init(arrayLiteral: "&", "+", ":")))
    }
    
    private func separated(transform: ([Self]) -> Browse?) -> Browse? {
        transform(components(separatedBy: "."))
    }
}
