import Foundation

extension Page {
    public struct Deeplink: Hashable {
        let scheme: String
        let value: String
        
        public var url: URL? {
            .init(string: value)
        }
        
        init(value: String) {
            self.value = value
            scheme = value
                .components(separatedBy: "://")
                .first ?? ""
        }
    }
}
