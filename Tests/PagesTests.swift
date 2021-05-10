import XCTest
@testable import Sleuth

final class PagesTests: XCTestCase {
    func testProperty() {
        let page = Page(id: 1234,
                          title: "adsdasafas",
                          access: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"),
                          date: .init(timeIntervalSince1970: 10))
        XCTAssertEqual(page, page.data.prototype())
    }
    
    func testAccess() {
        XCTAssertEqual("https://www.aguacate.com", Page(id: 0, access: .init(url: URL(string: "https://www.aguacate.com")!)).url.absoluteString)
    }
}
