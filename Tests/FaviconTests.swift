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
    
    func testLoadUnknown() {
        favicon.load(domain: "aguacate")
        
        favicon
            .icons
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
    }
    
    func testSave() {
        let expect = expectation(description: "")
        let data = Data("hello world".utf8)
        
        favicon
            .icons
            .map {
                $0["aguacate"]
            }
            .compactMap {
                $0
            }
            .sink {
                XCTAssertEqual(Thread.main, Thread.current)
                XCTAssertEqual(data, $0)
                XCTAssertEqual(data, try? Data(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("icons/aguacate")))
                expect.fulfill()
            }
            .store(in: &subs)
        
        DispatchQueue
            .global(qos: .utility)
            .async {
                self.favicon.save(domain: "aguacate", data: data)
            }
        
        waitForExpectations(timeout: 1)
    }
}
