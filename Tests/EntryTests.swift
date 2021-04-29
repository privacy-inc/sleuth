import XCTest
@testable import Sleuth

final class EntryTests: XCTestCase {
    func testProperty() {
        let entry = Entry(id: 1234,
                          title: "adsdasafas",
                          bookmark: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"),
                          date: .init(timeIntervalSince1970: 10))
        XCTAssertEqual(entry, entry.data.prototype())
    }
    
    func testAccess() {
        XCTAssertEqual("https://www.aguacate.com", Entry(id: 0, url: URL(string: "https://www.aguacate.com")!).access?.absoluteString)
    }
}
