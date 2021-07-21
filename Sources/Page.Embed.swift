import Foundation

extension Page {
    public struct Embed: Hashable {
        public let prefix: String
        public let value: String
        
        init(value: String) {
            self.value = value
            self.prefix = value
                .components(separatedBy: ";")
                .first ?? ""
        }
        
        public var url: URL? {
            .init(string: value)
        }
    }
}
