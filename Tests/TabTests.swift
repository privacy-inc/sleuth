import XCTest
@testable import Sleuth

final class TabTests: XCTestCase {
    private var tab: Tab!
    
    override func setUp() {
        tab = .init()
    }
    
    func testInitial() {
        if case .new = tab.items.first?.state {
            
        } else {
            XCTFail()
        }
    }
    
    func testNew() {
        tab.items = [.init().with(state: .browse(1))]
        let id = tab.new()
        XCTAssertEqual(2, tab.items.count)
        XCTAssertEqual(tab.items.first?.id, id)
    }
    
    func testNewNoRepeat() {
        let id = tab.new()
        XCTAssertEqual(1, tab.items.count)
        XCTAssertEqual(tab.items.last?.id, id)
    }
    
    func testbrowse() {
        tab.browse(tab.items.first!.id, 33)
        XCTAssertEqual(1, tab.items.count)
        if case let .browse(browse) = tab.items.first?.state {
            XCTAssertEqual(33, browse)
        } else {
            XCTFail()
        }
    }
    
    func testError() {
        tab.items = [.init().with(state: .browse(33))]
        tab.error(tab.items.first!.id, .init(url: "https://aguacate.com", description: "No internet connection"))
        XCTAssertEqual(1, tab.items.count)
        if case let .error(browse, error) = tab.items.first?.state {
            XCTAssertEqual(33, browse)
            XCTAssertEqual("https://aguacate.com", error.url)
            XCTAssertEqual("No internet connection", error.description)
        } else {
            XCTFail()
        }
    }
    
    func testDismiss() {
        tab.items = [.init().with(state: .error(33, .init(url: "hello.com", description: "Some error")))]
        tab.dismiss(tab.items.first!.id)
        XCTAssertEqual(1, tab.items.count)
        if case let .browse(browse) = tab.items.first?.state {
            XCTAssertEqual(33, browse)
        } else {
            XCTFail()
        }
    }
    
    func testClear() {
        let web = NSNumber(value: 1)
        tab.items = [.init()
                        .with(state: .error(33, .init(url: "hello.com", description: "Some error")))
                        .with(web: web)]
        XCTAssertNotNil(tab.items.first?.web)
        tab.clear(tab.items.first!.id)
        XCTAssertEqual(1, tab.items.count)
        if case .new = tab.items.first?.state {
            XCTAssertNil(tab.items.first?.web)
        } else {
            XCTFail()
        }
    }
    
    func testState() {
        tab.items = [.init().with(state: .browse(33))]
        if case let .browse(browse) = tab.state(tab.items.first!.id) {
            XCTAssertEqual(33, browse)
        } else {
            XCTFail()
        }
    }
    
    func testStateUnknown() {
        if case .new = tab.state(UUID()) {
            
        } else {
            XCTFail()
        }
    }
    
    func testClose() {
        tab.items = [.init().with(state: .browse(2)), .init().with(state: .browse(3))]
        tab.close(tab.items.first!.id)
        XCTAssertEqual(1, tab.items.count)
        if case let .browse(browse) = tab.items.first?.state {
            XCTAssertEqual(3, browse)
        } else {
            XCTFail()
        }
    }
    
    func testCloseLast() {
        tab.items = [.init().with(state: .browse(3))]
        tab.close(tab.items.first!.id)
        XCTAssertEqual(1, tab.items.count)
        if case .new = tab.items.first?.state {
            
        } else {
            XCTFail()
        }
    }
    
    func testCloseAll() {
        tab.items = [.init().with(state: .browse(2)), .init().with(state: .browse(3))]
        let id = tab.closeAll()
        XCTAssertEqual(1, tab.items.count)
        XCTAssertEqual(tab.items.first?.id, id)
        if case .new = tab.items.first?.state {
        } else {
            XCTFail()
        }
    }
}
