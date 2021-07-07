import XCTest
@testable import Sleuth

final class browseTests: XCTestCase {
    func testProperty() {
        let browse = Browse(id: 1234,
                            page: .init(title: "adsdasafas", access: .remote(.init(value: "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"))),
                          date: .init(timeIntervalSince1970: 10))
        XCTAssertEqual(browse, browse.data.prototype())
    }
    
    func testAccess() {
        XCTAssertEqual("https://www.aguacate.com", Browse(id: 0, page: .init(access: .init(url: URL(string: "https://www.aguacate.com")!))).page.access.value)
    }
}
