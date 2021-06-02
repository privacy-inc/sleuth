import XCTest
@testable import Sleuth

final class PageTests: XCTestCase {
    func testProperty() {
        let page = Page(title: "adsdasafas", access: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"))
        XCTAssertEqual(page, page.data.prototype())
    }
    
    func testAccess() {
        XCTAssertEqual("https://www.aguacate.com", Page(access: .init(url: URL(string: "https://www.aguacate.com")!)).access.url?.absoluteString)
    }
    
    func testSubtitle() {
        XCTAssertEqual("aguacate.com", Page(title: "adsdasafas", access: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1")).access.domain)
    }
    
    func testSecure() {
        XCTAssertTrue(Page(title: "", access: .init(url: URL(string: "https://www.aguacate.com")!)).secure)
        XCTAssertTrue(Page(title: "", access: .init(url: URL(fileURLWithPath: "aguacate"))).secure)
        XCTAssertFalse(Page(title: "", access: .init(url: URL(string: "http://www.aguacate.com")!)).secure)
        XCTAssertFalse(Page(title: "", access: .init(url: URL(string: "ftp://www.aguacate.com")!)).secure)
    }
}
