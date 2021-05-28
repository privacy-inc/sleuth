import XCTest
import Combine
@testable import Sleuth

final class TabTests: XCTestCase {
    private var tab: Tab!
    private var subs: Set<AnyCancellable>!
    
    override func setUp() {
        tab = .init()
        subs = []
    }
    
    func testInitial() {
        if case .new = tab.items.value.first?.state {
            
        } else {
            XCTFail()
        }
    }
    
    func testNew() {
        tab.items.value = [.init().with(state: .browse(1))]
        let id = tab.new()
        XCTAssertEqual(2, tab.items.value.count)
        XCTAssertEqual(tab.items.value.first?.id, id)
    }
    
    func testNewNoRepeat() {
        let id = tab.new()
        XCTAssertEqual(1, tab.items.value.count)
        XCTAssertEqual(tab.items.value.last?.id, id)
    }
    
    func testbrowse() {
        tab.browse(tab.items.value.first!.id, 33)
        XCTAssertEqual(1, tab.items.value.count)
        if case let .browse(browse) = tab.items.value.first?.state {
            XCTAssertEqual(33, browse)
        } else {
            XCTFail()
        }
    }
    
    func testError() {
        tab.items.value = [.init().with(state: .browse(33))]
        tab.error(tab.items.value.first!.id, .init(url: "https://aguacate.com", description: "No internet connection"))
        XCTAssertEqual(1, tab.items.value.count)
        if case let .error(browse, error) = tab.items.value.first?.state {
            XCTAssertEqual(33, browse)
            XCTAssertEqual("https://aguacate.com", error.url)
            XCTAssertEqual("No internet connection", error.description)
        } else {
            XCTFail()
        }
    }
    
    func testDismiss() {
        tab.items.value = [.init().with(state: .error(33, .init(url: "hello.com", description: "Some error")))]
        tab.dismiss(tab.items.value.first!.id)
        XCTAssertEqual(1, tab.items.value.count)
        if case let .browse(browse) = tab.items.value.first?.state {
            XCTAssertEqual(33, browse)
        } else {
            XCTFail()
        }
    }
    
    func testClear() {
        let web = NSNumber(value: 1)
        tab.items.value = [.init()
                        .with(state: .error(33, .init(url: "hello.com", description: "Some error")))
                        .with(web: web)]
        XCTAssertNotNil(tab.items.value.first?.web)
        tab.clear(tab.items.value.first!.id)
        XCTAssertEqual(1, tab.items.value.count)
        if case .new = tab.items.value.first?.state {
            XCTAssertNil(tab.items.value.first?.web)
        } else {
            XCTFail()
        }
    }
    
    func testState() {
        tab.items.value = [.init().with(state: .browse(33))]
        if case let .browse(browse) = tab.items.value.state(tab.items.value.first!.id) {
            XCTAssertEqual(33, browse)
        } else {
            XCTFail()
        }
    }
    
    func testStateUnknown() {
        if case .new = tab.items.value.state(UUID()) {
            
        } else {
            XCTFail()
        }
    }
    
    func testClose() {
        tab.items.value = [.init().with(state: .browse(2)), .init().with(state: .browse(3))]
        tab.close(tab.items.value.first!.id)
        XCTAssertEqual(1, tab.items.value.count)
        if case let .browse(browse) = tab.items.value.first?.state {
            XCTAssertEqual(3, browse)
        } else {
            XCTFail()
        }
    }
    
    func testCloseAtomic() {
        let expect = expectation(description: "")
        tab.items.value = [.init().with(state: .browse(2))]
        
        tab
            .items
            .dropFirst()
            .sink { _ in
                expect.fulfill()
            }
            .store(in: &subs)
        
        tab.close(tab.items.value.first!.id)
        waitForExpectations(timeout: 1)
    }
    
    func testCloseLast() {
        tab.items.value = [.init().with(state: .browse(3))]
        tab.close(tab.items.value.first!.id)
        XCTAssertEqual(1, tab.items.value.count)
        if case .new = tab.items.value.first?.state {
            
        } else {
            XCTFail()
        }
    }
    
    func testCloseAll() {
        tab.items.value = [.init().with(state: .browse(2)), .init().with(state: .browse(3))]
        let id = tab.closeAll()
        XCTAssertEqual(1, tab.items.value.count)
        XCTAssertEqual(tab.items.value.first?.id, id)
        if case .new = tab.items.value.first?.state {
        } else {
            XCTFail()
        }
    }
}
