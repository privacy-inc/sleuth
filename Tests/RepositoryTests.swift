import XCTest
import Combine
import Archivable
@testable import Sleuth

final class RepositoryTests: XCTestCase {
    private var cloud: Cloud<Repository>.Stub!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        cloud = .init()
        cloud.archive.value = .new
    }
    
    func testBrowse() {
        let expectSave = expectation(description: "")
        let expectBrowse = expectation(description: "")
        cloud.archive.value.counter = 99
        
        cloud.save.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual("https://hello.com", $0.entries.first?.url)
            XCTAssertEqual(99, $0.entries.first?.id)
            XCTAssertEqual(100, $0.counter)
            expectSave.fulfill()
        }
        .store(in: &subs)
        
        cloud.browse(.google, "hello.com").sink {
            XCTAssertEqual("https://hello.com", $0?.0.url)
            XCTAssertEqual(99, $0?.1)
            expectBrowse.fulfill()
        }
        .store(in: &subs)
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseEmpty() {
        let expect = expectation(description: "")
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        cloud.browse(.google, "").sink {
            XCTAssertNil($0)
            expect.fulfill()
        }
        .store(in: &subs)
        
        waitForExpectations(timeout: 1)
    }
    
    func testAdd() {
        let expect = expectation(description: "")
        cloud.archive.value.counter = 99
        cloud.save.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual("hello.com", $0.entries.first?.url)
            XCTAssertEqual(99, $0.entries.first?.id)
            XCTAssertEqual(100, $0.counter)
            expect.fulfill()
        }
        .store(in: &subs)
        cloud.url("hello.com")
        waitForExpectations(timeout: 1)
    }
    
    func testRemove() {
//        let expect = expectation(description: "")
//        let date = Date()
//        let page = Entry(id: 0, url: "hello.com")
//        archive.entries = [page]
//        Repository.override!.sink {
//            XCTAssertTrue($0.entries.isEmpty)
//            XCTAssertGreaterThanOrEqual($0.date.timestamp, date.timestamp)
//            expect.fulfill()
//        }
//        .store(in: &subs)
////        archive.remove(page)
//        waitForExpectations(timeout: 1)
    }
    
    func testSameAdd() {
//        let url = "hello.com"
//        let page1 = Entry(id: 0, url: url)
//        let page2 = Entry(id: 0, url: url)
////        archive.add(&page1)
////        archive.add(&page2)
//        XCTAssertEqual(2, archive.entries.count)
    }
    
    func testUpdate() {
//        let page = Entry(id: 0, url: "hello.com")
////        archive.add(&page)
////        page.url = "lorem.com"
////        archive.add(&page)
////        XCTAssertEqual(1, archive.entries.count)
////        page.title = "Lorem"
////        archive.add(&page)
//        XCTAssertEqual(1, archive.entries.count)
    }
    
    func testRevisit() {
//        let date = Date(timeIntervalSince1970: 10)
//        let page = Entry(id: 0, url: "aguacate.com")
////        page.date = date
//        archive.entries = [page]
////        archive.add(&page)
//        XCTAssertEqual(1, archive.entries.count)
//        XCTAssertGreaterThan(archive.entries.first!.date.timestamp, date.timestamp)
    }
}
