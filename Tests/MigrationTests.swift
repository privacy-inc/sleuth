import XCTest
import Combine
import Archivable
@testable import Sleuth

final class MigrationTests: XCTestCase {
    private var cloud: Cloud<Archive>!
    private var subs: Set<AnyCancellable>!
    
    override func setUp() {
        cloud = .init(manifest: nil)
        subs = []
    }
    
    func testMigrateProtection() {
        let expect = expectation(description: "")
        
        FileManager.save(.init(url: URL(string: "https://aguacate.com")!))
        
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testArchiveNotNew() {
        let expect = expectation(description: "")
        
        FileManager.save(.init(url: URL(string: "https://aguacate.com")!))
        
        cloud.archive.value.counter = 1
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testNoPages() {
        let expect = expectation(description: "")
        
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testPages() {
        let expect = expectation(description: "")
        
        var pageA = Legacy.Page(url: URL(string: "https://aguacate.com")!)
        pageA.date = .init(timeIntervalSince1970: 10)
        pageA.title = "aguacate"
        
        var pageB = Legacy.Page(url: URL(string: "https://something.com")!)
        pageB.date = .init(timeIntervalSince1970: 20)
        pageB.title = "some"
        
        let pageC = Legacy.Page(url: URL(fileURLWithPath: "dasdas/dsadasds"))
        
        FileManager.save(pageA)
        FileManager.save(pageB)
        FileManager.save(pageC)
        
        cloud.save.sink {
            XCTAssertEqual(2, $0.entries.count)
            XCTAssertEqual(0, $0.entries.first?.id)
            XCTAssertEqual(1, $0.entries.last?.id)
            XCTAssertEqual("https://aguacate.com", $0.entries.first?.url)
            XCTAssertEqual("aguacate", $0.entries.first?.title)
            XCTAssertEqual(Date(timeIntervalSince1970: 10).timestamp, $0.entries.first?.date.timestamp)
            XCTAssertEqual("https://something.com", $0.entries.last?.url)
            XCTAssertEqual("some", $0.entries.last?.title)
            XCTAssertEqual(Date(timeIntervalSince1970: 20).timestamp, $0.entries.last?.date.timestamp)
            XCTAssertEqual(2, $0.counter)
            FileManager
                .pages
                .sink {
                    XCTAssertTrue($0.isEmpty)
                    expect.fulfill()
                }
                .store(in: &self.subs)
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testBlocked() {
        let expect = expectation(description: "")
        let date = Date()
        Legacy.Share.blocked = ["some", "other", "some"]
        
        cloud.save.sink {
            XCTAssertEqual(2, $0.blocked.count)
            XCTAssertEqual(2, $0.blocked["some"]?.count)
            XCTAssertEqual(1, $0.blocked["other"]?.count)
            $0.blocked
                .flatMap(\.value)
                .forEach {
                    XCTAssertGreaterThanOrEqual($0, date)
                }
            XCTAssertTrue(Legacy.Share.blocked.isEmpty)
            expect.fulfill()
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testActivity() {
        let expect = expectation(description: "")
        Legacy.Share.chart = [.init(timeIntervalSince1970: 10), .init(timeIntervalSince1970: 20)]
        
        cloud.save.sink {
            XCTAssertEqual(2, $0.activity.count)
            XCTAssertEqual(Date(timeIntervalSince1970: 10).timestamp, $0.activity.first?.timestamp)
            XCTAssertEqual(Date(timeIntervalSince1970: 20).timestamp, $0.activity.last?.timestamp)
            XCTAssertTrue(Legacy.Share.chart.isEmpty)
            expect.fulfill()
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testHistory() {
        let expect = expectation(description: "")
        Legacy.Share.chart = [.init()]
        Legacy.Share.history = [.init(url: URL(string: "https://www.hello.com")!, title: "", subtitle: "")]
        
        cloud.save.sink { _ in
            XCTAssertTrue(Legacy.Share.history.isEmpty)
            expect.fulfill()
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
        }
        
        waitForExpectations(timeout: 1)
    }
}
