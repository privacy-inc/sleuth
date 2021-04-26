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
        archive.entries = [.init(url: "aguacate.com")]
        XCTAssertEqual("aguacate.com", archive.data.mutating(transform: Archive.init(data:)).entries.first?.url)
    }
    
    func testActivity() {
        let date = Date(timeIntervalSince1970: 10)
        archive.activity = [date]
        XCTAssertEqual(date.timestamp, archive.data.mutating(transform: Archive.init(data:)).activity.first?.timestamp)
    }
    
    func testAdd() {
        let expect = expectation(description: "")
        let date = Date()
        let page = Entry(url: "hello.com")
        Repository.override!.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual("hello.com", $0.entries.first?.url)
            XCTAssertGreaterThanOrEqual($0.date.timestamp, date.timestamp)
            expect.fulfill()
        }
        .store(in: &subs)
//        archive.add(&page)
        waitForExpectations(timeout: 1)
    }
    
    func testRemove() {
        let expect = expectation(description: "")
        let date = Date()
        let page = Entry(url: "hello.com")
        archive.entries = [page]
        Repository.override!.sink {
            XCTAssertTrue($0.entries.isEmpty)
            XCTAssertGreaterThanOrEqual($0.date.timestamp, date.timestamp)
            expect.fulfill()
        }
        .store(in: &subs)
//        archive.remove(page)
        waitForExpectations(timeout: 1)
    }
    
    func testSameAdd() {
        let url = "hello.com"
        let page1 = Entry(url: url)
        let page2 = Entry(url: url)
//        archive.add(&page1)
//        archive.add(&page2)
        XCTAssertEqual(2, archive.entries.count)
    }
    
    func testUpdate() {
        let page = Entry(url: "hello.com")
//        archive.add(&page)
//        page.url = "lorem.com"
//        archive.add(&page)
//        XCTAssertEqual(1, archive.entries.count)
//        page.title = "Lorem"
//        archive.add(&page)
        XCTAssertEqual(1, archive.entries.count)
    }
    
    func testRevisit() {
        let date = Date(timeIntervalSince1970: 10)
        let page = Entry(url: "aguacate.com")
//        page.date = date
        archive.entries = [page]
//        archive.add(&page)
        XCTAssertEqual(1, archive.entries.count)
        XCTAssertGreaterThan(archive.entries.first!.date.timestamp, date.timestamp)
    }
}
