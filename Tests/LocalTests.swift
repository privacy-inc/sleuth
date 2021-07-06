import XCTest
@testable import Sleuth

final class LocalTests: XCTestCase {
    func testDomain() {
        XCTAssertEqual("image.png", Page.Local(value: "/private/var/mobile/Containers/Data/Application/74C82CFA-C973-4CDD-ADDF-8DC95C6E3B11/tmp/image.png", bookmark: .init()).file)
        XCTAssertEqual("index.html", Page.Local(value: "file:///Users/vaux/Downloads/about/index.html", bookmark: .init()).file)
    }
}
