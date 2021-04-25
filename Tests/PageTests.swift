import XCTest
import Sleuth

final class PageTests: XCTestCase {
    func testProperties() {
        let date = Date()
        let url = "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"
        var page = Page(url: url)
        page.title = "Aguacate"
        XCTAssertGreaterThanOrEqual(page.data.mutating(transform: Page.init(data:)).date.timestamp, date.timestamp)
        XCTAssertEqual(url, page.data.mutating(transform: Page.init(data:)).url)
        XCTAssertEqual("Aguacate", page.data.mutating(transform: Page.init(data:)).title)
    }
}
