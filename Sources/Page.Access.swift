import Foundation
import Archivable

extension Page {
    public enum Access: Hashable, Property {
        case
        remote(Remote),
        local(Local),
        deeplink(Deeplink)
        
        public var url: URL? {
            switch self {
            case let .remote(remote):
                return .init(string: remote.value)
            case let .local(local):
                return .init(string: local.value)
            case let .deeplink(deeplink):
                return .init(string: deeplink.value)
            }
        }
        
        public var short: String {
            switch self {
            case let .remote(remote):
                return remote
                    .domain
            case let .local(local):
                return local
                    .file
            case let .deeplink(deeplink):
                return deeplink
                    .scheme
            }
        }
        
        public var value: String {
            switch self {
            case let .remote(remote):
                return remote.value
            case let .local(local):
                return local.value
            case let .deeplink(deeplink):
                return deeplink.value
            }
        }
        
        public var data: Data {
            Data()
                .adding(key.rawValue)
                .adding(content)
        }
        
        public init(data: inout Data) {
            switch Key(rawValue: data.removeFirst())! {
            case .remote:
                self = .remote(.init(value: data.string()))
            case .local:
                self = .local(.init(value: data.string(), bookmark: data.unwrap()))
            case .deeplink:
                self = .deeplink(.init(value: data.string()))
            }
        }
        
        init(url: URL) {
            self = url.isFileURL
                ? .local(.init(value: url.absoluteString, bookmark: url.deletingLastPathComponent().bookmark))
                : {
                    switch $0 {
                    case .https, .http, .ftp:
                        return .remote(.init(value: url.absoluteString))
                    default:
                        return url.scheme == nil
                            ? .remote(.init(value: url.absoluteString))
                            : .deeplink(.init(value: url.absoluteString))
                    }
                } (url
                    .scheme
                    .map(URL.Scheme.init(rawValue:)))
        }
        
        private var content: Data {
            switch self {
            case let .remote(remote):
                return Data()
                    .adding(remote.value)
            case let .local(local):
                return Data()
                    .adding(local.value)
                    .wrapping(local.bookmark)
            case let .deeplink(deeplink):
                return Data()
                    .adding(deeplink.value)
            }
        }
    }
}
