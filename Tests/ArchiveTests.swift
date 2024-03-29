import XCTest
@testable import Sleuth

final class ArchiveTests: XCTestCase {
    private var archive: Archive!
    
    override func setUp() {
        archive = .new
    }
    
    func testDate() {
        archive = .new
        XCTAssertGreaterThanOrEqual(archive.data.prototype(Archive.self).timestamp, 0)
        archive.timestamp = 1
        XCTAssertGreaterThanOrEqual(archive.data.prototype(Archive.self).timestamp, 1)
    }
    
    func testCounter() {
        archive.counter = 19_999
        XCTAssertEqual(19_999, archive.data.prototype(Archive.self).counter)
    }
    
    func testbrowse() {
        let browse = Browse(id: 1234, page: .init(title: "adsdasafas", access: .remote(.init(value: "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1"))))
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
        let page = Page(title: "adsdasafas", access: .remote(.init(value: "https://www.aguacate.com:8080/asd/124?page=32123&lsd=1")))
        archive.bookmarks = [page]
        XCTAssertEqual(page, archive.data.prototype(Archive.self).bookmarks.first)
    }
    
    func testPlotter() {
        XCTAssertEqual([], archive.activity.plotter)
        archive.activity = [
            Calendar.current.date(byAdding: .day, value: -9, to: .init())!,
            Calendar.current.date(byAdding: .day, value: -9, to: .init())!,
            Calendar.current.date(byAdding: .day, value: -1, to: .init())!]
        XCTAssertEqual([1, 0, 0, 0, 0, 0, 0, 0, 0.5, 0], archive.activity.plotter)
    }
    
    func testTrackersAttempts() {
        archive.blocked = ["a": [.init()],
                           "b": [.init()],
                           "c": [.init(), .init()]]
        XCTAssertEqual("c", archive.trackers(.attempts).first?.name)
        XCTAssertEqual("b", archive.trackers(.attempts).last?.name)
    }
    
    func testTrackersRecent() {
        archive.blocked = ["a": [.distantPast],
                           "b": [.init(timeIntervalSinceNow: -10)],
                           "c": [.init(timeIntervalSinceNow: -30), .init(timeIntervalSinceNow: -50)]]
        XCTAssertEqual("b", archive.trackers(.recent).first?.name)
        XCTAssertEqual("a", archive.trackers(.recent).last?.name)
    }
    
    func testTrackersRecentLast() {
        archive.blocked = ["a": [.distantPast],
                           "b": [.init(timeIntervalSinceNow: -100), .init(timeIntervalSinceNow: -10)],
                           "c": [.init(timeIntervalSinceNow: -30), .init(timeIntervalSinceNow: -50)]]
        XCTAssertEqual("b", archive.trackers(.recent).first?.name)
        XCTAssertEqual("a", archive.trackers(.recent).last?.name)
    }
    
    func testTrackersCount() {
        archive.blocked = ["a": [.distantPast],
                           "b": [.init(timeIntervalSinceNow: -100), .init(timeIntervalSinceNow: -10)],
                           "c": [.init(timeIntervalSinceNow: -30), .init(timeIntervalSinceNow: -50)]]
        XCTAssertEqual(3, archive.trackers.count)
        XCTAssertEqual(5, archive.trackers.attempts)
    }
}
