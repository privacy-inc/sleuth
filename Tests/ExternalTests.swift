import XCTest
import Archivable
import Sleuth

final class ExternalTests: XCTestCase {
    private var cloud: Cloud<Repository>.Stub!
    private let list = [
        "some://www.ecosia.org",
        "apps://www.theguardian.com/email/form/footer/today-uk",
        "sms://uk.reuters.com/"
    ]

    override func setUp() {
        cloud = .init()
        cloud.archive.value = .new
    }
    
    func test() {
        list
            .map {
                ($0, cloud.validate(URL(string: $0)!, with: .antitracker))
            }
            .forEach {
                if case .external = $0.1 { } else {
                    XCTFail("\($0.1): \($0.0)")
                }
            }
    }
}
