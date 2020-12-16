import XCTest
import Sleuth
import Combine

final class ExternalTests: XCTestCase {
    private var shield: Shield!
    private var subs = Set<AnyCancellable>()
    private let list = [
        "some://www.ecosia.org",
        "apps://www.theguardian.com/email/form/footer/today-uk",
        "sms://uk.reuters.com/"
    ]
    
    override func setUp() {
        shield = .init()
    }
    
    func test() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = list.count
        list.forEach { url in
            shield.policy(for: URL(string: url)!, shield: true).sink {
                if case .external = $0 {
                    expect.fulfill()
                } else {
                    XCTFail(url)
                }
            }.store(in: &subs)
        }
        waitForExpectations(timeout: 1)
    }
}
