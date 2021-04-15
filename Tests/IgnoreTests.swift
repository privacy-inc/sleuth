import XCTest
import Sleuth

final class IgnoreTests: XCTestCase {
    private let list =  [
        "about:blank",
        "about:srcdoc"
    ]
    
    func test() {
        list
            .map {
                ($0, Shield.policy(for: URL(string: $0)!, shield: true))
            }
            .forEach {
                if case .ignore = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
