import XCTest
@testable import Sleuth

final class EntryTests: XCTestCase {
    func testProperty() {
        let entry = Entry(id: 1234, title: "adsdasafas", url: "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1")
        XCTAssertEqual(entry, entry.data.prototype())
    }
}
