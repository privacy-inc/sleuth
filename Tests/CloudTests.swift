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
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual("hello.com", $0.history.first?.page.domain)
                XCTAssertEqual(99, $0.history.first?.id)
                XCTAssertEqual(100, $0.counter)
                expectSave.fulfill()
            }
            .store(in: &subs)
        
        cloud.browse("hello.com", id: nil) {
            XCTAssertTrue(Thread.current.isMainThread)
            XCTAssertEqual(99, $0)
            XCTAssertEqual(100, self.cloud.archive.value.counter)
            expectBrowse.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseSecond() {
        let expect = expectation(description: "")
        cloud.archive.value.counter = 99
        
        cloud
            .archive
            .dropFirst(2)
            .sink {
                XCTAssertEqual(2, $0.history.count)
                XCTAssertEqual("hello2.com", $0.history.first?.page.domain)
                XCTAssertEqual(100, $0.history.first?.id)
                XCTAssertEqual(101, $0.counter)
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.browse("hello.com", id: nil) { _ in }
        cloud.browse("hello2.com", id: nil) { _ in }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseId() {
        let expectArchive = expectation(description: "")
        let expectBrowse = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.counter = 99
        cloud.archive.value.history = [.init(id: 33, page: .init(title: "hello bla bla", access: .remote("aguacate.com")), date: date)]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual("hello.com", $0.history.first?.page.domain)
                XCTAssertEqual(33, $0.history.first?.id)
                XCTAssertEqual(99, $0.counter)
                XCTAssertGreaterThan($0.history.first!.date, date)
                expectArchive.fulfill()
            }
            .store(in: &subs)
        
        cloud.browse("hello.com", id: 33) {
            XCTAssertEqual(33, $0)
            expectBrowse.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseIdUnknown() {
        let expectArchive = expectation(description: "")
        let expectBrowse = expectation(description: "")
        cloud.archive.value.counter = 99
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual("hello.com", $0.history.first?.page.domain)
                XCTAssertEqual(99, $0.history.first?.id)
                XCTAssertEqual(100, $0.counter)
                expectArchive.fulfill()
            }
            .store(in: &subs)
        
        cloud.browse("hello.com", id: 55) {
            XCTAssertNotEqual(55, $0)
            expectBrowse.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBrowseMultiple() {
        let expect = expectation(description: "")
        cloud.archive.value.counter = 99
        cloud.browse("hello.com", id: nil) { _ in }
        cloud.browse("hello.com", id: nil) { _ in }
        
        cloud.browse("hello.com", id: nil) {
            XCTAssertEqual(101, $0)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(3, self.cloud.archive.value.history.count)
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
        
        cloud.browse("", id: nil) { _ in
            XCTFail()
        }
    }
    
    func testBrowseIdEmpty() {
        cloud.archive.value.history = [.init(id: 22, page: .init(title: "hello bla bla", access: .remote("aguacate.com")))]
        
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        
        cloud.browse("", id: 22) { _ in
            XCTFail()
        }
    }
    
    func testRevisit() {
        let expect = expectation(description: "")
        let date = Date(timeIntervalSinceNow: -10)
        cloud.archive.value.history = [.init(id: 33, page: .init(title: "hello bla bla", access: .remote("aguacate.com")), date: date)]
        cloud.archive.value.counter = 99
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual("aguacate.com", $0.history.first?.page.string)
                XCTAssertEqual("hello bla bla", $0.history.first?.page.title)
                XCTAssertGreaterThan($0.history.first!.date, date)
                XCTAssertEqual(33, $0.history.first?.id)
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
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual("hello.com", $0.history.first?.page.domain)
                XCTAssertEqual(99, $0.history.first?.id)
                XCTAssertEqual(100, $0.counter)
                if case .remote = $0.history.first?.page.access { } else {
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
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual(file.schemeless, $0.history.first?.page.domain)
                XCTAssertEqual(99, $0.history.first?.id)
                XCTAssertEqual(100, $0.counter)
                if case let .local(url, bookmark) = $0.history.first?.page.access {
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
        cloud.archive.value.history = [.init(id: 33, page: .init(title: "hello bla bla", access: .remote("aguacate.com")), date: date)]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual("hello world", $0.history.first?.page.title)
                XCTAssertEqual("aguacate.com", $0.history.first?.page.domain)
                XCTAssertEqual(33, $0.history.first?.id)
                XCTAssertEqual(0, $0.counter)
                XCTAssertGreaterThan($0.history.first!.date, date)
                if case .remote = $0.history.first?.page.access { } else {
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
        cloud.archive.value.history = [.init(id: 33, page: .init(title: "hello bla bla", access: .remote("aguacate.com")), date: date)]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.history.count)
                XCTAssertEqual("hello bla bla", $0.history.first?.page.title)
                XCTAssertEqual("avocado.com", $0.history.first?.page.domain)
                XCTAssertEqual(33, $0.history.first?.id)
                XCTAssertEqual(0, $0.counter)
                XCTAssertGreaterThan($0.history.first!.date, date)
                if case .remote = $0.history.first?.page.access { } else {
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
        cloud.archive.value.history = [.init(id: 33, page: .init(access: .remote("aguacate.com")))]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.history.isEmpty)
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
    
    func testActivityRepeat() {
        let expect = expectation(description: "")
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.activity.count)
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.activity()
        cloud.activity()
        
        waitForExpectations(timeout: 1)
    }
    
    func testActivityLessThan1Minute() {
        cloud.archive.value.activity = [Calendar.current.date(byAdding: .second, value: -55, to: .init())!]
        
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        
        cloud.activity()
    }
    
    func testActivity1Minute() {
        let expect = expectation(description: "")
        cloud.archive.value.activity = [Calendar.current.date(byAdding: .minute, value: -2, to: .init())!]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(2, $0.activity.count)
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.activity()
        
        waitForExpectations(timeout: 1)
    }
    
    func testForget() {
        let expect = expectation(description: "")
        let date = Date()
        
        cloud.archive.value.counter = 99
        cloud.archive.value.history = [.init(id: 33, page: .init(title: "hello bla bla", access: .remote("aguacate.com")), date: date)]
        cloud.archive.value.date = .init(timeIntervalSince1970: 10)
        cloud.archive.value.blocked = ["some" : [.init()]]
        cloud.archive.value.activity = [.init()]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.history.isEmpty)
                XCTAssertTrue($0.blocked.isEmpty)
                XCTAssertTrue($0.activity.isEmpty)
                XCTAssertEqual(0, $0.counter)
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
        
        _ = cloud.policy(URL(string: "https://googleapis.com")!)
        _ = cloud.policy(URL(string: "https://google.com")!)
        _ = cloud.policy(URL(string: "https://googleapis.com")!)
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(1, self.cloud.archive.value.blocked.count)
            XCTAssertEqual(2, self.cloud.archive.value.blocked.first?.value.count)
        }
    }
    
    func testBookmark() {
        let expect = expectation(description: "")
        cloud.archive.value.history = [.init(id: 33, page: .init(title: "hello bla bla", access: .remote("aguacate.com")))]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.bookmarks.count)
                XCTAssertEqual("hello bla bla", $0.bookmarks.first?.title)
                XCTAssertEqual("aguacate.com", $0.bookmarks.first?.string)
                if case .remote = $0.bookmarks.first?.access { } else {
                    XCTFail()
                }
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.bookmark(33)
        
        waitForExpectations(timeout: 1)
    }
    
    func testBookmarkRepeat() {
        let expect = expectation(description: "")
        cloud.archive.value.bookmarks = [.init(title: "hello bla bla", access: .remote("aguacate.com"))]
        cloud.archive.value.history = [.init(id: 33, page: .init(title: "hello tum tum", access: .remote("aguacate.com")))]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(1, $0.bookmarks.count)
                XCTAssertEqual("hello tum tum", $0.bookmarks.first?.title)
                XCTAssertEqual("aguacate.com", $0.bookmarks.first?.string)
                if case .remote = $0.bookmarks.first?.access { } else {
                    XCTFail()
                }
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.bookmark(33)
        
        waitForExpectations(timeout: 1)
    }
    
    func testBookmarkOpen() {
        let expect = expectation(description: "")
        cloud.archive.value.bookmarks = [.init(title: "hello bla bla", access: .remote("aguacate.com"))]
        
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual("aguacate.com", $0.history.first?.page.domain)
                XCTAssertEqual(1, $0.counter)
                expect.fulfill()
            }
            .store(in: &subs)
        
        cloud.open(0)
        
        waitForExpectations(timeout: 1)
    }
    
    func testBookmarkOpenOutOfBounds() {
        cloud
            .archive
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
        
        cloud.open(0)
    }
    
    func testEngine() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertEqual(.ecosia, $0.settings.engine)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.engine(.ecosia)
        waitForExpectations(timeout: 1)
    }
    
    func testJavascript() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertFalse($0.settings.javascript)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.javascript(false)
        waitForExpectations(timeout: 1)
    }
    
    func testDark() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertFalse($0.settings.dark)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.dark(false)
        waitForExpectations(timeout: 1)
    }
    
    func testPopups() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.settings.popups)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.popups(true)
        waitForExpectations(timeout: 1)
    }
    
    func testAds() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.settings.ads)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.ads(true)
        waitForExpectations(timeout: 1)
    }
    
    func testScreen() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.settings.screen)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.screen(true)
        waitForExpectations(timeout: 1)
    }
    
    func testTrackers() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.settings.trackers)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.trackers(true)
        waitForExpectations(timeout: 1)
    }
    
    func testCookies() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.settings.cookies)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.cookies(true)
        waitForExpectations(timeout: 1)
    }
    
    func testHttp() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.settings.http)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.http(true)
        waitForExpectations(timeout: 1)
    }
    
    func testLocation() {
        let expect = expectation(description: "")
        cloud
            .archive
            .dropFirst()
            .sink {
                XCTAssertTrue($0.settings.location)
                expect.fulfill()
            }
            .store(in: &subs)
        cloud.location(true)
        waitForExpectations(timeout: 1)
    }
}
