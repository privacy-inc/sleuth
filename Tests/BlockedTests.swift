import XCTest
import Combine
import Archivable
@testable import Sleuth

final class BlockedTests: XCTestCase {
    private var cloud: Cloud<Archive>!
    private var subs: Set<AnyCancellable>!
    
    override func setUp() {
        cloud = .init(manifest: nil)
        subs = []
    }
    
    func testBlockMultiple() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = 2
        
        cloud.save.sink { _ in
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
        
        cloud.save.sink {
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
        
        cloud.save.sink {
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
        
        cloud.save.sink {
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
        cloud.save.sink { _ in
            XCTFail()
        }
        .store(in: &subs)
        
        _ = cloud.validate(URL(string: "https://" + Site.Domain.twitter_platform.rawValue)!, with: .simple)
    }
}
