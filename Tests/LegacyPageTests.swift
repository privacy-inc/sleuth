import XCTest
import Sleuth

final class LegacyPageTests: XCTestCase {
    func testItem() {
        var page = Legacy.Page(url: URL(string: "https://aguacate.com")!)
        page.title = "Aguacate"
        XCTAssertEqual(URL(string: "privacy-id://" + page.id.uuidString), page.shared.url)
        XCTAssertEqual("Aguacate", page.shared.title)
        XCTAssertEqual("aguacate.com", page.shared.subtitle)
    }
    
    func testHttps() {
        XCTAssertEqual("avocado.com", Legacy.Page(url: URL(string: "https://www.avocado.com")!).shared.subtitle)
        XCTAssertEqual("avocado.com", Legacy.Page(url: URL(string: "https://avocado.com")!).shared.subtitle)
    }
    
    func testHttp() {
        XCTAssertEqual("avocado.com", Legacy.Page(url: URL(string: "http://www.avocado.com")!).shared.subtitle)
        XCTAssertEqual("avocado.com", Legacy.Page(url: URL(string: "http://avocado.com")!).shared.subtitle)
    }
}
