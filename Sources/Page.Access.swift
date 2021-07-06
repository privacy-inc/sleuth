import Foundation
import Archivable

extension Page {
    public enum Access: Hashable, Property {
        case
        remote(Remote),
        local(Local)
        
        public var url: URL? {
            switch self {
            case let .remote(remote):
                return .init(string: remote.value)
            case let .local(local):
                return .init(string: local.value)
            }
        }
        
        public var short: String {
            ""
        }
        
        public var secure: Bool {
            switch self {
            case let .remote(remote):
                return remote.secure
            case .local:
                return true
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
            }
        }
        
        init(url: URL) {
            self = url.isFileURL
                ? .local(.init(value: url.absoluteString, bookmark: url.deletingLastPathComponent().bookmark))
                : .remote(.init(value: url.absoluteString))
        }
        
        var value: String {
            switch self {
            case let .remote(remote):
                return remote.value
            case let .local(local):
                return local.value
            }
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
            }
        }
    }
}
