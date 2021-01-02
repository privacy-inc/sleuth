import XCTest
import Sleuth

final class PageTests: XCTestCase {
    func testItem() {
        var page = Page(url: URL(string: "https://aguacate.com")!)
        page.title = "Aguacate"
        XCTAssertEqual(URL(string: "privacy_id://" + page.id.uuidString), page.item.url)
        XCTAssertEqual("Aguacate", page.item.title)
        XCTAssertEqual("https://aguacate.com", page.item.subtitle)
    }
}
