import Foundation

extension Page {
    public struct Local: Hashable {
        public let path: String
        let value: String
        let file: String
        let bookmark: Data
        
        init(value: String, bookmark: Data) {
            self.value = value
            self.bookmark = bookmark
            path = value
                .components(separatedBy: "://")
                .last ?? ""
            file = path
                .components(separatedBy: "/")
                .last ?? ""
        }
        
        public func open(completion: (URL) -> Void) {
            bookmark
                .url
                .map(completion)
        }
    }
}
