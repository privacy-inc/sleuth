import Foundation

extension String {
    var domain: Self {
        components(separatedBy: "://")
            .last
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
    
    func browse<T>(engine: Engine, result: (String, Browse) -> T) -> T? {
        {
            $0.flatMap {
                $0.1 == .none ? nil : result($0.0, $0.1)
            }
        } (trimmed {
            $0.url
                ?? $0.partial
                ?? $0.query(engine)
        })
    }
    
    private func trimmed(transform: (Self) -> (url: Self, browse: Browse)) -> (url: Self, browse: Browse)? {
        {
            $0.isEmpty ? nil : transform($0)
        } (trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    private func query(_ engine: Engine) -> (url: Self, browse: Browse) {
        {
            (engine.search + $0, .search)
        } (addingPercentEncoding(withAllowedCharacters:
                                    .urlQueryAllowed
                                    .subtracting(.init(arrayLiteral: "&", "+", ":")))
        ?? self)
    }
    
    private var url: (url: Self, browse: Browse)? {
        URL(string: self)
            .flatMap {
                $0.scheme != nil && ($0.host != nil || $0.query != nil)
                    ? (self, .navigate)
                    : nil
            }
    }
    
    private var partial: (url: Self, browse: Browse)? {
        {
            $0.count > 1 && $0.last!.count > 1 && $0.first!.count > 1
                ? (URL.Scheme.https.rawValue + "://" + self, .navigate)
                : nil
        } (components(separatedBy: "."))
    }
}
