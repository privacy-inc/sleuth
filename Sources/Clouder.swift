import Foundation
import Combine
import Archivable

extension Clouder where C == Repository {
    public func browse(_ engine: Engine, _ url: String) -> Future<(Engine.Browse, Int)?, Never> {
        .init { promise in
            mutating {
                guard let browse = engine.browse(url) else {
                    return promise(.success(nil))
                }
                let id = $0.counter
                $0.entries.append(.init(id: id, browse: browse))
                $0.counter += 1
                promise(.success((browse, id)))
            }
        }
    }
    
    public func navigate(_ url: URL) -> Future<Int, Never> {
        .init { promise in
            mutating {
                let id = $0.counter
                $0.entries.append(.init(id: id, url: url))
                $0.counter += 1
                promise(.success(id))
            }
        }
    }
    
    @discardableResult public func revisit(_ id: Int) -> Future<Entry?, Never> {
        .init { promise in
            mutating {
                guard let entry = $0.entries.remove(id: id)?.revisit else {
                    return promise(.success(nil))
                }
                $0.entries.append(entry)
                promise(.success(entry))
            }
        }
    }
    
    public func update(_ id: Int, title: String) {
        mutating {
            guard let entry = $0.entries.remove(id: id)?.with(title: title) else { return }
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
            Site.Ignore(rawValue: $0)
                .map { _ in
                    .ignore
                } ?? Scheme(rawValue: $0)
                    .map { _ in
                        switch protection {
                        case .antitracker:
                            if let domain = url.host {
                                for site in Site.Domain.allCases {
                                    guard domain.hasSuffix(site.rawValue) else { continue }
                                    return .block(domain)
                                }
                                
                                for site in Site.Partial.allCases {
                                    guard
                                        domain.hasSuffix(site.domain.rawValue),
                                        url.path.hasPrefix(site.rawValue)
                                    else { continue }
                                    return .block(site.url)
                                }
                                
                                for item in domain.components(separatedBy: ".").dropLast() {
                                    guard Site.Component(rawValue: item) == nil else { return .block(domain) }
                                    continue
                                }
                            }
                        default: break
                        }
                        return .allow
                    }
        } ?? .external
    }
}
