import XCTest
@testable import Sleuth

final class DeeplinkTests: XCTestCase {
    func testScheme() {
        XCTAssertEqual("itms-services", Page.Deeplink(value: "itms-services://?action=purchaseIntent&bundleId=incognit&productIdentifier=incognit.plus").scheme)
    }
}
