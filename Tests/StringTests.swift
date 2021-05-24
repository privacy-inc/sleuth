import XCTest
@testable import Sleuth

final class StringTests: XCTestCase {
    func testDomain() {
        XCTAssertEqual("https://", "https://".domain)
        XCTAssertEqual("", "".domain)
        XCTAssertEqual("wds", "wds".domain)
        XCTAssertEqual("linkedin.com", "https://www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a"
                        .domain)
    }
}
