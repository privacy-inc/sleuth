import XCTest
import Sleuth
import Combine

final class IgnoreTests: XCTestCase {
    private var shield: Shield!
    private var subs = Set<AnyCancellable>()
    private let list =  [
        "about:blank",
        "about:srcdoc"
    ]
    
    override func setUp() {
        shield = .init()
    }
    
    func test() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = list.count
        list.forEach { url in
            shield.policy(for: URL(string: url)!, shield: true).sink {
                if case .ignore = $0 {
                    expect.fulfill()
                } else {
                    XCTFail("\($0): \(url)")
                }
            }.store(in: &subs)
        }
        waitForExpectations(timeout: 1)
    }
}
