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
        tab.items = [.init().with(state: .history(1))]
        let id = tab.new()
        XCTAssertEqual(2, tab.items.count)
        XCTAssertEqual(tab.items.first?.id, id)
    }
    
    func testNewNoRepeat() {
        let id = tab.new()
        XCTAssertEqual(1, tab.items.count)
        XCTAssertEqual(tab.items.last?.id, id)
    }
    
    func testHistory() {
        tab.history(tab.items.first!.id, 33)
        XCTAssertEqual(1, tab.items.count)
        if case let .history(history) = tab.items.first?.state {
            XCTAssertEqual(33, history)
        } else {
            XCTFail()
        }
    }
    
    func testError() {
        tab.items = [.init().with(state: .history(33))]
        tab.error(tab.items.first!.id, .init(url: "https://aguacate.com", description: "No internet connection"))
        XCTAssertEqual(1, tab.items.count)
        if case let .error(history, error) = tab.items.first?.state {
            XCTAssertEqual(33, history)
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
        if case let .history(history) = tab.items.first?.state {
            XCTAssertEqual(33, history)
        } else {
            XCTFail()
        }
    }
    
    func testState() {
        tab.items = [.init().with(state: .history(33))]
        if case let .history(history) = tab.state(tab.items.first!.id) {
            XCTAssertEqual(33, history)
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
}
