import Foundation

extension Page {
    public struct Local: Hashable {
        public let value: String
        public let bookmark: Data
        
        init(value: String, bookmark: Data) {
            self.value = value
            self.bookmark = bookmark
        }
        
        public var directory: URL? {
            bookmark
                .url
        }
    }
}
