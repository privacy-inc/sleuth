import Foundation

extension Page {
    public struct Remote: Hashable {
        public let domain: String
        public let suffix: String
        let value: String
        
        init(value: String) {
            self.value = value
            domain = value.domain
            suffix = ""
        }
        
        var secure: Bool {
            value
                .hasPrefix(URL
                                .Scheme
                                .https
                                .rawValue)
        }
        
        public func hash(into: inout Hasher) {
            into.combine(value)
        }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.value == rhs.value
        }
    }
}
