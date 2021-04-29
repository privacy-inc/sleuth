import XCTest
@testable import Sleuth

final class MigrationTests: XCTestCase {
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
        
        FileManager.queue.async {
            
        }
        
        waitForExpectations(timeout: 1)
    }
}
