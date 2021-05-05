import Foundation
import Combine
import Archivable

extension Cloud where A == Archive {
    public static let shared = Self(manifest: .init(
                                        file: "Privacy.archive",
                                        container: "iCloud.privacy",
                                        prefix: "privacy_",
                                        title: "Privacy"))
    
    public func entry(_ id: Int) -> Entry? {
        archive.value.entries.first {
            $0.id == id
        }
    }
    
    public func browse(_ search: String, completion: @escaping(Engine.Browse, Int) -> Void) {
        mutating {
            guard let browse = Defaults.engine.browse(search) else { return nil }
            return (browse, $0.add(browse))
        } completion: { (result: (Engine.Browse, Int)) in
            completion(result.0, result.1)
        }
    }
    
    public func browse(_ id: Int, _ search: String, completion: @escaping(Engine.Browse) -> Void) {
        mutating(transform: {
            guard let browse = Defaults.engine.browse(search) else { return nil }
            if let entry = $0.entries.remove(id: id)?.with(browse: browse) {
                $0.entries.append(entry)
            } else {
                $0.add(browse)
            }
            return browse
        }, completion: completion)
    }
    
    public func navigate(_ url: URL, completion: @escaping(Int) -> Void) {
        mutating(transform: {
            $0.add(url)
        }, completion: completion)
    }
    
    public func revisit(_ id: Int) {
        mutating {
            guard let entry = $0.entries.remove(id: id)?.revisit else { return }
            $0.entries.append(entry)
        }
    }
    
    public func update(_ id: Int, title: String) {
        mutating {
            guard let entry = $0.entries.remove(id: id)?.with(title: title.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
            $0.entries.append(entry)
        }
    }
    
    public func update(_ id: Int, url: URL) {
        mutating {
            guard let entry = $0.entries.remove(id: id)?.with(url: url) else { return }
            $0.entries.append(entry)
        }
    }
    
    public func remove(_ id: Int) {
        mutating {
            $0.entries.remove(id: id)
        }
    }
    
    public func activity() {
        mutating {
            $0.activity.append(.init())
        }
    }
    
    public func validate(_ url: URL, with protection: Protection) -> Protection.Result {
        url.scheme.flatMap {
            URL.Ignore(rawValue: $0)
                .map { _ in
                    .ignore
                } ?? Scheme(rawValue: $0)
                    .map { _ in
                        switch protection {
                        case .antitracker:
                            if let domain = url.host {
                                for black in URL.Black.allCases {
                                    guard domain.hasSuffix(black.rawValue) else { continue }
                                    block(black.rawValue)
                                    return .block
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
                                        
                                        print(black.1)
                                        print("contains: \(path)")
                                            guard
                                                domain.hasSuffix(black.0),
                                                black.1.contains(path)
                                            else { continue }
                                        block(black.0 + "/" + path)
                                            return .block
                                        }
                                }
                                
                                for item in domain.components(separatedBy: ".").dropLast() {
                                    guard Site.Component(rawValue: item) == nil else {
                                        block(domain)
                                        return .block
                                    }
                                    continue
                                }
                            }
                        default: break
                        }
                        return .allow
                    }
        } ?? .external
    }
    
    public func forget() {
        mutating {
            $0.entries = []
            $0.activity = []
            $0.blocked = [:]
        }
    }
    
    private func block(_ url: String) {
        mutating {
            $0.blocked[url, default: []].append(.init())
        }
    }
}
