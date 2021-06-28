import Foundation

extension String {
    var domain: Self {
        ({ comps in
            switch comps.first {
            case "http", "https":
                return comps
                    .dropFirst()
                    .first
                    .flatMap {
                        $0
                            .components(separatedBy: "/")
                            .first
                            .flatMap {
                                $0
                                    .components(separatedBy: ":")
                                    .first
                                    .flatMap {
                                        $0.isEmpty
                                        ? nil
                                        : $0
                                    }
                            }
                    }
            case "file":
                return components(separatedBy: "/")
                    .last
            case nil:
                return nil
            default:
                return comps
                    .first!
                    .isEmpty
                    || comps.count == 1
                        ? {
                            $0.first!.contains(".") ? $0.first : $0.last
                        } (components(separatedBy: "/"))
                        : comps.first!
            }
        } (components(separatedBy: "://")) ?? self).replacingOccurrences(of: "www.", with: "")
    }
    
    func browse<T>(engine: Engine, result: (String) -> T) -> T? {
        trimmed {
            $0.url
                ?? $0.partial
                ?? $0.query(engine)
        }
        .map(result)
    }
    
    private func trimmed(transform: (Self) -> Self) -> Self? {
        {
            $0.isEmpty ? nil : transform($0)
        } (trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    private func query(_ engine: Engine) -> Self {
        encoded
            .map {
                engine.search + $0
            }
        ?? self
    }
    
    private var url: Self? {
        {
            $0.count > 1 ? URL(string: $0.first! + "?" + $0
                                .dropFirst()
                                .compactMap {
                                    $0.encoded
                                }
                                .joined(separator: "?")) : .init(string: self)
        } (components(separatedBy: "?"))
        .flatMap {
            $0.scheme != nil && ($0.host != nil || $0.query != nil)
                ? self
                : nil
        }
    }
    
    private var partial: Self? {
        {
            $0.count > 1
                && $0.last!.count > 1
                && $0.first!.count > 1
                && !$0.first!.contains("/")
                && !components(separatedBy: "?").first!.contains(" ")
                ? URL.Scheme.https.rawValue + "://" + self
                : nil
        } (components(separatedBy: "."))
    }
    
    private var encoded: Self? {
        addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
                .subtracting(.init(arrayLiteral: "&", "+", ":")))
    }
}
