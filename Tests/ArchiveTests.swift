import XCTest
@testable import Sleuth

final class ArchiveTests: XCTestCase {
    private var archive: Archive!
    
    override func setUp() {
        archive = .new
    }
    
    func testDate() {
        let date0 = Date(timeIntervalSince1970: 0)
        archive = .new
        XCTAssertGreaterThanOrEqual(archive.data.prototype(Archive.self).date.timestamp, date0.timestamp)
        let date1 = Date(timeIntervalSince1970: 1)
        archive.date = date1
        XCTAssertGreaterThanOrEqual(archive.data.prototype(Archive.self).date.timestamp, date1.timestamp)
    }
    
    func testCounter() {
        archive.counter = 19_999
        XCTAssertEqual(19_999, archive.data.prototype(Archive.self).counter)
    }
    
    func testEntries() {
        let entry = Entry(id: 1234, title: "adsdasafas", bookmark: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"))
        archive.entries = [entry]
        XCTAssertEqual(entry, archive.data.prototype(Archive.self).entries.first)
    }
    
    func testActivity() {
        let date = Date(timeIntervalSince1970: 10)
        archive.activity = [date]
        XCTAssertEqual(date.timestamp, archive.data.prototype(Archive.self).activity.first?.timestamp)
    }
    
    func testBlocked() {
        let date1 = Date(timeIntervalSince1970: 10)
        let date2 = Date(timeIntervalSince1970: 20)
        let date3 = Date(timeIntervalSince1970: 30)
        archive.blocked = ["hello world": [date1, date2],
                           "lorem ipsum": [date3]]
        XCTAssertEqual(date1.timestamp, archive.data.prototype(Archive.self).blocked["hello world"]?.first?.timestamp)
        XCTAssertEqual(date2.timestamp, archive.data.prototype(Archive.self).blocked["hello world"]?.last?.timestamp)
        XCTAssertEqual(date3.timestamp, archive.data.prototype(Archive.self).blocked["lorem ipsum"]?.first?.timestamp)
    }
}
