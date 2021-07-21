import Foundation

extension Page {
    public struct Embed: Hashable {
        public let value: String
        public let prefix: String
        
        init(value: String) {
            self.value = value
            self.prefix = value
                .components(separatedBy: ";")
                .first ?? ""
        }
    }
}
