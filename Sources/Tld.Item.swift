import Foundation

extension Tld {
    public struct Item: RawRepresentable {
        public let rawValue: Tld
        let mode: Mode
        
        public init(tld: Tld, mode: Mode) {
            rawValue = tld
            self.mode = mode
        }
        
        public init?(rawValue: Tld) {
            nil
        }
    }
}
