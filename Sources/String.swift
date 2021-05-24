import Foundation

extension String {
    var domain: Self {
        components(separatedBy: "://")
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
                                    .replacingOccurrences(of: "www.", with: "")
                            }
                    }
            } ?? self
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
        addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
                .subtracting(.init(arrayLiteral: "&", "+", ":")))
            .map {
                engine.search + $0
            }
        ?? self
    }
    
    private var url: Self? {
        URL(string: self)
            .flatMap {
                $0.scheme != nil && ($0.host != nil || $0.query != nil)
                    ? self
                    : nil
            }
    }
    
    private var partial: Self? {
        {
            $0.count > 1 && $0.last!.count > 1 && $0.first!.count > 1
                ? URL.Scheme.https.rawValue + "://" + self
                : nil
        } (components(separatedBy: "."))
    }
}
