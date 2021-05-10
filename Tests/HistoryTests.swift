import XCTest
@testable import Sleuth

final class HistoryTests: XCTestCase {
    func testProperty() {
        let history = History(id: 1234,
                          page: .init(title: "adsdasafas", access: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1")),
                          date: .init(timeIntervalSince1970: 10))
        XCTAssertEqual(history, history.data.prototype())
    }
    
    func testAccess() {
        XCTAssertEqual("https://www.aguacate.com", History(id: 0, page: .init(access: .init(url: URL(string: "https://www.aguacate.com")!))).url.absoluteString)
    }
}
