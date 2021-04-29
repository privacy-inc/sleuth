import XCTest
import Sleuth

final class IgnoreTests: XCTestCase {
    private var protection: Protection!
    private let list =  [
        "about:blank",
        "about:srcdoc"
    ]
    
    override func setUp() {
        protection = .antitracker
    }
    
    func test() {
        list
            .map {
                ($0, protection.policy(for: URL(string: $0)!))
            }
            .forEach {
                if case .ignore = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
