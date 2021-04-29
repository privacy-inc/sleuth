import XCTest
@testable import Sleuth

final class URLTests: XCTestCase {
    func testSchemeless() {
        XCTAssertEqual("/some/thing", URL(fileURLWithPath: "/some/thing").schemeless)
        XCTAssertEqual("avocado.com", URL(string: "https://avocado.com")?.schemeless)
        XCTAssertEqual("avocado.com", URL(string: "http://avocado.com")?.schemeless)
        XCTAssertEqual("avocado.com", URL(string: "privacy://avocado.com")?.schemeless)
        XCTAssertEqual("avocado.com", URL(string: "avocado.com")?.schemeless)
    }
}
