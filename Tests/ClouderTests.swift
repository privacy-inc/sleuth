import XCTest
import Combine
import Archivable
@testable import Sleuth

final class ClouderTests: XCTestCase {
    private var cloud: Cloud<Synch>.Stub!
    private var subs: Set<AnyCancellable>!
    
    override func setUp() {
        cloud = .init()
        cloud.archive.value = .new
        subs = []
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
        
        cloud.browse("hello.com").sink {
            XCTAssertEqual("https://hello.com", $0?.0.url)
            XCTAssertEqual(99, $0?.1)
            expectBrowse.fulfill()
        }
        .store(in: &subs)
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseMultiple() {
        let expect = expectation(description: "")
        cloud.archive.value.counter = 99
        _ = cloud.browse("hello.com")
        _ = cloud.browse("hello.com")
        
        cloud.browse("hello.com").sink {
            XCTAssertEqual(101, $0?.1)
            expect.fulfill()
        }
        .store(in: &subs)
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(3, self.cloud.archive.value.entries.count)
        }
    }
    
    func testBrowseEmpty() {
        let expect = expectation(description: "")
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        cloud.browse("").sink {
            XCTAssertNil($0)
            expect.fulfill()
        }
        .store(in: &subs)
        
        waitForExpectations(timeout: 1)
    }
    
    func testRevisit() {
        let expect = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.entries = [.init(id: 33, title: "hello bla bla", bookmark: .remote("aguacate.com"), date: date)]
        cloud.archive.value.counter = 99
        
        cloud.save.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual("aguacate.com", $0.entries.first?.url)
            XCTAssertEqual("hello bla bla", $0.entries.first?.title)
            XCTAssertGreaterThan($0.entries.first!.date, date)
            XCTAssertEqual(33, $0.entries.first?.id)
            XCTAssertEqual(99, $0.counter)
            expect.fulfill()
        }
        .store(in: &subs)
        
        cloud.revisit(33)
        
        waitForExpectations(timeout: 1)
    }
    
    func testRevisitUnknown() {
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        cloud.revisit(33)
    }
    
    func testNavigateRemote() {
        let expectSave = expectation(description: "")
        let expectNavigate = expectation(description: "")
        cloud.archive.value.counter = 99
        
        cloud.save.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual("https://hello.com", $0.entries.first?.url)
            XCTAssertEqual(99, $0.entries.first?.id)
            XCTAssertEqual(100, $0.counter)
            if case .remote = $0.entries.first?.bookmark { } else {
                XCTFail()
            }
            expectSave.fulfill()
        }
        .store(in: &subs)
        
        cloud.navigate(URL(string: "https://hello.com")!).sink {
            XCTAssertEqual(99, $0)
            expectNavigate.fulfill()
        }
        .store(in: &subs)
        
        waitForExpectations(timeout: 1)
    }
    
    func testNavigateLocal() {
        let expectSave = expectation(description: "")
        let expectNavigate = expectation(description: "")
        cloud.archive.value.counter = 99
        
        let file = URL(fileURLWithPath: NSTemporaryDirectory() + "file.html")
        try! Data("hello world".utf8).write(to: file)
        
        cloud.save.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual(file.schemeless, $0.entries.first?.url)
            XCTAssertEqual(99, $0.entries.first?.id)
            XCTAssertEqual(100, $0.counter)
            if case let .local(url, bookmark) = $0.entries.first?.bookmark {
                XCTAssertEqual(file.schemeless, url)
                XCTAssertFalse(bookmark.isEmpty)
            } else {
                XCTFail()
            }
            expectSave.fulfill()
        }
        .store(in: &subs)
        
        cloud.navigate(file).sink {
            XCTAssertEqual(99, $0)
            expectNavigate.fulfill()
        }
        .store(in: &subs)
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateTitle() {
        let expect = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.entries = [.init(id: 33, title: "hello bla bla", bookmark: .remote("aguacate.com"), date: date)]
        
        cloud.save.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual("hello world", $0.entries.first?.title)
            XCTAssertEqual("aguacate.com", $0.entries.first?.url)
            XCTAssertEqual(33, $0.entries.first?.id)
            XCTAssertEqual(0, $0.counter)
            XCTAssertGreaterThan($0.entries.first!.date, date)
            if case .remote = $0.entries.first?.bookmark { } else {
                XCTFail()
            }
            expect.fulfill()
        }
        .store(in: &subs)
        
        cloud.update(33, title: "hello world    ")
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateURL() {
        let expect = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.entries = [.init(id: 33, title: "hello bla bla", bookmark: .remote("aguacate.com"), date: date)]
        
        cloud.save.sink {
            XCTAssertEqual(1, $0.entries.count)
            XCTAssertEqual("hello bla bla", $0.entries.first?.title)
            XCTAssertEqual("avocado.com", $0.entries.first?.url)
            XCTAssertEqual(33, $0.entries.first?.id)
            XCTAssertEqual(0, $0.counter)
            XCTAssertGreaterThan($0.entries.first!.date, date)
            if case .remote = $0.entries.first?.bookmark { } else {
                XCTFail()
            }
            expect.fulfill()
        }
        .store(in: &subs)
        
        cloud.update(33, url: URL(string: "avocado.com")!)
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateUnknown() {
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        cloud.update(33, title: "hello world")
        cloud.update(33, url: URL(string: "avocado.com")!)
    }
    
    func testRemove() {
        let expect = expectation(description: "")
        cloud.archive.value.entries = [.init(id: 33, bookmark: .remote("aguacate.com"))]
        
        cloud.save.sink {
            XCTAssertTrue($0.entries.isEmpty)
            expect.fulfill()
        }
        .store(in: &subs)
        
        cloud.remove(33)
        
        waitForExpectations(timeout: 1)
    }
    
    func testRemoveUnknown() {
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        cloud.remove(33)
    }
    
    func testActivity() {
        let expect = expectation(description: "")
        let date = Date()
        
        cloud.save.sink {
            XCTAssertEqual(1, $0.activity.count)
            XCTAssertGreaterThanOrEqual($0.activity.first!, date)
            expect.fulfill()
        }
        .store(in: &subs)
        
        cloud.activity()
        
        waitForExpectations(timeout: 1)
    }
    
    func testForget() {
        let expect = expectation(description: "")
        let date = Date()
        
        cloud.archive.value.entries = [.init(id: 33, title: "hello bla bla", bookmark: .remote("aguacate.com"), date: date)]
        cloud.archive.value.date = .init(timeIntervalSince1970: 10)
        cloud.archive.value.blocked = ["some" : [.init()]]
        cloud.archive.value.activity = [.init()]
        
        cloud.save.sink {
            XCTAssertTrue($0.entries.isEmpty)
            XCTAssertTrue($0.blocked.isEmpty)
            XCTAssertTrue($0.activity.isEmpty)
            XCTAssertGreaterThan($0.date, date)
            expect.fulfill()
        }
        .store(in: &subs)
        
        cloud.forget()
        
        waitForExpectations(timeout: 1)
    }
}
