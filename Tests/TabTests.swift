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
        let item = tab.new()
        XCTAssertEqual(2, tab.items.count)
        XCTAssertEqual(tab.items.last?.id, item.id)
    }
    
    func testNewNoRepeat() {
        let item = tab.new()
        XCTAssertEqual(1, tab.items.count)
        XCTAssertEqual(tab.items.last?.id, item.id)
    }
}
