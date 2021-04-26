import XCTest
import Combine
@testable import Sleuth

final class ArchiveTests: XCTestCase {
    private var archive: Archive!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        archive = .new
        Repository.override = .init()
    }
    
    func testDate() {
        let date0 = Date(timeIntervalSince1970: 0)
        archive = .new
        XCTAssertGreaterThanOrEqual(archive.data.mutating(transform: Archive.init(data:)).date.timestamp, date0.timestamp)
        let date1 = Date(timeIntervalSince1970: 1)
        archive.date = date1
        XCTAssertGreaterThanOrEqual(archive.data.mutating(transform: Archive.init(data:)).date.timestamp, date1.timestamp)
    }
    
    func testPages() {
        archive.pages = [.init(url: "aguacate.com")]
        XCTAssertEqual("aguacate.com", archive.data.mutating(transform: Archive.init(data:)).pages.first?.url)
    }
    
    func testActivity() {
        let date = Date(timeIntervalSince1970: 10)
        archive.activity = [date]
        XCTAssertEqual(date.timestamp, archive.data.mutating(transform: Archive.init(data:)).activity.first?.timestamp)
    }
    
    func testAdd() {
        let expect = expectation(description: "")
        let date = Date()
        var page = Page(url: "hello.com")
        Repository.override!.sink {
            XCTAssertEqual(1, $0.pages.count)
            XCTAssertEqual("hello.com", $0.pages.first?.url)
            XCTAssertGreaterThanOrEqual($0.date.timestamp, date.timestamp)
            expect.fulfill()
        }
        .store(in: &subs)
        archive.add(&page)
        waitForExpectations(timeout: 1)
    }
    
    func testRemove() {
        let expect = expectation(description: "")
        let date = Date()
        let page = Page(url: "hello.com")
        archive.pages = [page]
        Repository.override!.sink {
            XCTAssertTrue($0.pages.isEmpty)
            XCTAssertGreaterThanOrEqual($0.date.timestamp, date.timestamp)
            expect.fulfill()
        }
        .store(in: &subs)
        archive.remove(page)
        waitForExpectations(timeout: 1)
    }
    
    func testSameAdd() {
        let url = "hello.com"
        var page1 = Page(url: url)
        var page2 = Page(url: url)
        archive.add(&page1)
        archive.add(&page2)
        XCTAssertEqual(2, archive.pages.count)
    }
    
    func testUpdate() {
        var page = Page(url: "hello.com")
        archive.add(&page)
        page.url = "lorem.com"
        archive.add(&page)
        XCTAssertEqual(1, archive.pages.count)
        page.title = "Lorem"
        archive.add(&page)
        XCTAssertEqual(1, archive.pages.count)
    }
    
    func testRevisit() {
        let date = Date(timeIntervalSince1970: 10)
        var page = Page(url: "aguacate.com")
        page.date = date
        archive.pages = [page]
        archive.add(&page)
        XCTAssertEqual(1, archive.pages.count)
        XCTAssertGreaterThan(archive.pages.first!.date.timestamp, date.timestamp)
    }
}
