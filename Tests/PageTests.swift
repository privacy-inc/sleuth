import XCTest
import Sleuth

final class PageTests: XCTestCase {
    func testItem() {
        var page = Page(url: URL(string: "https://aguacate.com")!)
        page.title = "Aguacate"
        XCTAssertEqual(URL(string: "privacy-id://" + page.id.uuidString), page.shared.url)
        XCTAssertEqual("Aguacate", page.shared.title)
        XCTAssertEqual("https://aguacate.com", page.shared.subtitle)
    }
}
