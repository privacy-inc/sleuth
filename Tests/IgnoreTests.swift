import XCTest
import Sleuth
import Combine

final class IgnoreTests: XCTestCase {
    private var shield: Shield!
    private var subs = Set<AnyCancellable>()
    private let list =  [
        "about:blank",
        "about:srcdoc",
        "data:text/html;charset=utf-8;base64,PGltZyBzcmM9Imh0dHBzOi8vd3d3LmJldDM2NS5jb20vZmF2aWNvbi5pY28iPg=="
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
