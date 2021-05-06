import XCTest
import Sleuth

final class ExternalTests: XCTestCase {
    private var router: Router!
    private let list = [
        "some://www.ecosia.org",
        "apps://www.theguardian.com/email/form/footer/today-uk",
        "sms://uk.reuters.com/",
        "dsddasdsa://"
    ]

    override func setUp() {
        router = .secure
    }
    
    func test() {
        list
            .map {
                ($0, router(URL(string: $0)!))
            }
            .forEach {
                if case .external = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
