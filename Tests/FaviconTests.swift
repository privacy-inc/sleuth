import XCTest
import Combine
@testable import Sleuth

final class FaviconTests: XCTestCase {
    private var favicon: Favicon!
    private var subs: Set<AnyCancellable>!
    
    override func setUp() {
        favicon = .init()
        subs = .init()
    }
    
    func testGet() {
        favicon
            .get(domain: "aguacate.com")
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
    }
}
