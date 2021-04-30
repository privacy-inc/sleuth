import XCTest
import Combine
import Archivable
@testable import Sleuth

final class MigrationTests: XCTestCase {
    private var cloud: Cloud<Repository>.Stub!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        cloud = .init()
        cloud.archive.value = .new
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
            XCTAssertEqual(0, $0.entries.last?.id)
            XCTAssertEqual("https://aguacate.com", $0.entries.first?.url)
            XCTAssertEqual("https://something.com", $0.entries.last?.url)
            XCTAssertEqual(2, $0.counter)
            expect.fulfill()
        }
        .store(in: &subs)
        
        FileManager.queue.async {
            self.cloud.migrate()
        }
        
        waitForExpectations(timeout: 1)
    }
}
