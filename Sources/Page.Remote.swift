import Foundation

extension Page {
    public struct Remote: Hashable {
        public let value: String
        public let base: String
        public let suffix: String
        
        init(value: String) {
            self.value = value
            base = ""
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
