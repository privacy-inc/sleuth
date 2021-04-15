import XCTest
import Sleuth

final class ExternalTests: XCTestCase {
    private let list = [
        "some://www.ecosia.org",
        "apps://www.theguardian.com/email/form/footer/today-uk",
        "sms://uk.reuters.com/"
    ]

    func test() {
        list
            .map {
                ($0, Shield.policy(for: URL(string: $0)!, shield: true))
            }
            .forEach {
                if case .external = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
