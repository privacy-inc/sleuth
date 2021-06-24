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
    
    func testbrowse() {
        let browse = Browse(id: 1234, page: .init(title: "adsdasafas", access: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1")))
        archive.browses = [browse]
        XCTAssertEqual(browse, archive.data.prototype(Archive.self).browses.first)
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
    
    func testSettings() {
        archive.settings.engine = .ecosia
        XCTAssertEqual(.ecosia, archive.data.prototype(Archive.self).settings.engine)
    }
    
    func testBookmarks() {
        let page = Page(title: "adsdasafas", access: .remote("https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"))
        archive.bookmarks = [page]
        XCTAssertEqual(page, archive.data.prototype(Archive.self).bookmarks.first)
    }
    
    func testPlotter() {
        XCTAssertEqual([], archive.plotter)
        archive.activity = [
            Calendar.current.date(byAdding: .day, value: -9, to: .init())!,
            Calendar.current.date(byAdding: .day, value: -9, to: .init())!,
            Calendar.current.date(byAdding: .day, value: -1, to: .init())!]
        XCTAssertEqual([1, 0, 0, 0, 0, 0, 0, 0, 0.5, 0], archive.plotter)
    }
    
    func testTrackers() {
        archive.blocked = ["a": [.init()],
                           "b": [.init()],
                           "c": [.init(), .init()]]
        XCTAssertEqual("c", archive.trackers.first?.name)
        XCTAssertEqual("b", archive.trackers.last?.name)
    }
}
