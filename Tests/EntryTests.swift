import XCTest
@testable import Sleuth

final class EntryTests: XCTestCase {
    func testProperties() {
        let date = Date()
        let url = "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"
        let page = Entry(url: url)
                        .with(title: "Aguacate")
        XCTAssertGreaterThanOrEqual(page.data.mutating(transform: Entry.Info.init(data:)).date.timestamp, date.timestamp)
        XCTAssertEqual(url, page.data.mutating(transform: Entry.Info.init(data:)).url)
        XCTAssertEqual("Aguacate", page.data.mutating(transform: Entry.Info.init(data:)).title)
    }
}
