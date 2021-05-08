import XCTest
import Combine
import Archivable
@testable import Sleuth

final class CloudTests: XCTestCase {
    private var cloud: Cloud<Archive>!
    private var subs: Set<AnyCancellable>!
    
    override func setUp() {
        cloud = .init(manifest: nil)
        subs = []
    }
    
    func testBrowse() {
        let expectSave = expectation(description: "")
        let expectBrowse = expectation(description: "")
        cloud.archive.value.counter = 99
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.entries.count)
                XCTAssertEqual("https://hello.com", $0.entries.first?.url)
                XCTAssertEqual(99, $0.entries.first?.id)
                XCTAssertEqual(100, $0.counter)
                expectSave.fulfill()
            }
            .store(in: &subs)
        
        cloud.browse("hello.com") {
            XCTAssertTrue(Thread.current.isMainThread)
            XCTAssertEqual(.navigate, $1)
            XCTAssertEqual(99, $0)
            XCTAssertEqual(100, self.cloud.archive.value.counter)
            expectBrowse.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseId() {
        let expectSave = expectation(description: "")
        let expectBrowse = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.counter = 99
        cloud.archive.value.entries = [.init(id: 33, title: "hello bla bla", bookmark: .remote("aguacate.com"), date: date)]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.entries.count)
                XCTAssertEqual("https://hello.com", $0.entries.first?.url)
                XCTAssertEqual(33, $0.entries.first?.id)
                XCTAssertEqual(99, $0.counter)
                XCTAssertGreaterThan($0.entries.first!.date, date)
                expectSave.fulfill()
            }
            .store(in: &subs)
        
        cloud.browse(33, "hello.com") {
            XCTAssertTrue(Thread.current.isMainThread)
            XCTAssertEqual(.navigate, $0)
            XCTAssertGreaterThan(self.cloud.archive.value.entries.first!.date, date)
            expectBrowse.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseIdUnknown() {
        let expectSave = expectation(description: "")
        let expectBrowse = expectation(description: "")
        cloud.archive.value.counter = 99
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.entries.count)
                XCTAssertEqual("https://hello.com", $0.entries.first?.url)
                XCTAssertEqual(99, $0.entries.first?.id)
                XCTAssertEqual(100, $0.counter)
                expectSave.fulfill()
            }
            .store(in: &subs)
        
        cloud.browse(55, "hello.com") {
            XCTAssertEqual(.navigate, $0)
            XCTAssertEqual(100, self.cloud.archive.value.counter)
            expectBrowse.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseMultiple() {
        let expect = expectation(description: "")
        cloud.archive.value.counter = 99
        cloud.browse("hello.com") { _, _ in }
        cloud.browse("hello.com") { _, _ in }
        
        cloud.browse("hello.com") { id, _ in
            XCTAssertEqual(101, id)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(3, self.cloud.archive.value.entries.count)
        }
    }
    
    func testBrowseEmpty() {
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        
        cloud.browse("") { _, _ in
            XCTFail()
        }
    }
    
    func testBrowseIdEmpty() {
        cloud.archive.value.entries = [.init(id: 22, title: "hello bla bla", bookmark: .remote("aguacate.com"))]
        
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        
        cloud.browse(22, "") { _ in
            XCTFail()
        }
    }
    
    func testRevisit() {
        let expect = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.entries = [.init(id: 33, title: "hello bla bla", bookmark: .remote("aguacate.com"), date: date)]
        cloud.archive.value.counter = 99
        
        cloud
            .archive
            .dropFirst()
            .sink {
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
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        cloud.revisit(33)
    }
    
    func testNavigateRemote() {
        let expectSave = expectation(description: "")
        let expectNavigate = expectation(description: "")
        cloud.archive.value.counter = 99
        
        cloud
            .archive
            .dropFirst()
            .sink {
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
        
        cloud.navigate(URL(string: "https://hello.com")!) {
            XCTAssertEqual(99, $0)
            XCTAssertEqual(100, self.cloud.archive.value.counter)
            expectNavigate.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testNavigateLocal() {
        let expectSave = expectation(description: "")
        let expectNavigate = expectation(description: "")
        cloud.archive.value.counter = 99
        
        let file = URL(fileURLWithPath: NSTemporaryDirectory() + "file.html")
        try! Data("hello world".utf8).write(to: file)
        
        cloud
            .archive
            .dropFirst()
            .sink {
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
        
        cloud.navigate(file) {
            XCTAssertEqual(99, $0)
            XCTAssertEqual(100, self.cloud.archive.value.counter)
            expectNavigate.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateTitle() {
        let expect = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.entries = [.init(id: 33, title: "hello bla bla", bookmark: .remote("aguacate.com"), date: date)]
        
        cloud
            .archive
            .dropFirst()
            .sink {
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
        
        cloud
            .archive
            .dropFirst()
            .sink {
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
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        
        cloud.update(33, title: "hello world")
        cloud.update(33, url: URL(string: "avocado.com")!)
    }
    
    func testRemove() {
        let expect = expectation(description: "")
        cloud.archive.value.entries = [.init(id: 33, bookmark: .remote("aguacate.com"))]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.entries.isEmpty)
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.remove(33)
        
        waitForExpectations(timeout: 1)
    }
    
    func testRemoveUnknown() {
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        
        cloud.remove(33)
    }
    
    func testActivity() {
        let expect = expectation(description: "")
        let date = Date()
        
        cloud
            .archive
            .dropFirst()
            .sink {
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
        
        cloud
            .archive
            .dropFirst()
            .sink {
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
    
    func testBlock() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = 2
        
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.block("twitter.com")
        cloud.block("twitter.com")
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(1, self.cloud.archive.value.blocked.count)
            XCTAssertEqual(2, self.cloud.archive.value.blocked.first?.value.count)
        }
    }
    
    
    
    
    
    
    
    
    /*
    func testBlockMultiple() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = 2
        
        cloud.archive.dropFirst().sink { _ in
            expect.fulfill()
        }
        .store(in: &subs)
        
        _ = cloud.validate(URL(string: "https://" + Site.Domain.twitter_platform.rawValue)!, with: .antitracker)
        _ = cloud.validate(URL(string: "https://" + Site.Domain.twitter_platform.rawValue)!, with: .antitracker)
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(1, self.cloud.archive.value.blocked.count)
            XCTAssertEqual(2, self.cloud.archive.value.blocked.first?.value.count)
        }
    }
    
    func testDomain() {
        let expect = expectation(description: "")
        let subject = Site.Domain.twitter_platform
        let date = Date(timeIntervalSinceNow: -10)
        
        cloud.archive.dropFirst().sink {
            XCTAssertEqual(1, $0.blocked.count)
            XCTAssertEqual(1, $0.blocked.first?.value.count)
            XCTAssertEqual(subject.rawValue, $0.blocked.first?.key)
            XCTAssertGreaterThanOrEqual($0.blocked.first!.value.first!, date)
            expect.fulfill()
        }
        .store(in: &subs)
        
        _ = cloud.validate(URL(string: "https://something" + subject.rawValue)!, with: .antitracker)
        
        waitForExpectations(timeout: 1)
    }
    
    func testPartial() {
        let expect = expectation(description: "")
        let subject = Site.Partial.reddit_account
        let date = Date(timeIntervalSinceNow: -10)
        
        cloud.archive.dropFirst().sink {
            XCTAssertEqual(1, $0.blocked.count)
            XCTAssertEqual(1, $0.blocked.first?.value.count)
            XCTAssertEqual(subject.url, $0.blocked.first?.key)
            XCTAssertGreaterThanOrEqual($0.blocked.first!.value.first!, date)
            expect.fulfill()
        }
        .store(in: &subs)
        
        _ = cloud.validate(URL(string: "https://" + subject.url + "/dsdasdsaasd")!, with: .antitracker)
        
        waitForExpectations(timeout: 1)
    }
    
    func testComponent() {
        let expect = expectation(description: "")
        let url = URL(string: "https://hello." + Site.Component.adition.rawValue + ".dssaa.com/sadsadas/dasdsad/dasdsa.html")!
        let date = Date(timeIntervalSinceNow: -10)
        
        cloud.archive.dropFirst().sink {
            XCTAssertEqual(1, $0.blocked.count)
            XCTAssertEqual(1, $0.blocked.first?.value.count)
            XCTAssertEqual(url.host, $0.blocked.first?.key)
            XCTAssertGreaterThanOrEqual($0.blocked.first!.value.first!, date)
            expect.fulfill()
        }
        .store(in: &subs)
        
        _ = cloud.validate(url, with: .antitracker)
        
        waitForExpectations(timeout: 1)
    }
    
    func testSimple() {
        cloud.archive.dropFirst().sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        _ = cloud.validate(URL(string: "https://" + Site.Domain.twitter_platform.rawValue)!, with: .simple)
    }*/
}
