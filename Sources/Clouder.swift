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
                promise(.success((browse, $0.add(browse))))
            }
        }
    }
    
    public func navigate(_ url: URL) -> Future<Int, Never> {
        .init { promise in
            mutating {
                promise(.success($0.add(url)))
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
                                    block(site.rawValue)
                                    return .block
                                }
                                
                                for site in Site.Partial.allCases {
                                    guard
                                        domain.hasSuffix(site.domain.rawValue),
                                        url.path.hasPrefix(site.rawValue)
                                    else { continue }
                                    block(site.url)
                                    return .block
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
    
    public func block(_ url: String) {
        mutating {
            $0.blocked[url, default: []].append(.init())
        }
    }
    
    public func migrate() {
        guard archive.value == .new else { return }
        
        var sub: AnyCancellable?
        sub = FileManager
            .pages
            .sink { pages in
                sub?.cancel()
                
                guard !pages.isEmpty else { return }
                
                mutating { archive in
                    archive.entries = pages
                        .filter {
                            !$0.url.isFileURL
                        }
                        .enumerated()
                        .map {
                            .init(id: $0.0, title: $0.1.title, bookmark: .remote($0.1.url.absoluteString), date: $0.1.date)
                        }
                    archive.counter = archive.entries.count
                }
            }
    }
}
