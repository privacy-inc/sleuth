import Foundation

extension Page {
    public struct Deeplink: Hashable {
        let scheme: String
        let value: String
        
        init(value: String) {
            self.value = value
            scheme = value
                .components(separatedBy: "://")
                .first ?? ""
        }
    }
}
