import XCTest
import Combine
@testable import Sleuth

final class TabTests: XCTestCase {
    private var tab: Tab!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        tab = .init()
    }
    
    func testNew() {
        XCTAssertEqual(1, tab.items.value.count)
        XCTAssertNil(tab.items.value.first?.page.value)
        XCTAssertNil(tab.selected.value.page.value)
        XCTAssertEqual(tab.selected.value, tab.items.value.first)
    }
    
    func testNewEmpty() {
        let expectItems = expectation(description: "")
        let expectSelected = expectation(description: "")
        
        tab.items.dropFirst().sink {
            XCTAssertEqual(2, $0.count)
            XCTAssertNil($0.first?.page.value)
            XCTAssertNil($0.last?.page.value)
            expectItems.fulfill()
        }.store(in: &subs)
        
        tab.selected.dropFirst().sink {
            XCTAssertNil($0.page.value)
            expectSelected.fulfill()
        }.store(in: &subs)
        
        tab.new()
        XCTAssertEqual(tab.selected.value, tab.items.value.last)
        
        waitForExpectations(timeout: 1)
    }
    
    func testOpen() {
        let expect = expectation(description: "")
        
        tab.selected.value.browse.sink {
            XCTAssertEqual("https://google.com", $0.absoluteString)
            expect.fulfill()
        }.store(in: &subs)
        
        tab.open(URL(string: "https://google.com")!)
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdate() {
        let expect = expectation(description: "")
        
        tab.open(URL(string: "https://yahoo.com")!)
        
        tab.selected.value.browse.sink {
            XCTAssertEqual("https://google.com", $0.absoluteString)
            expect.fulfill()
        }.store(in: &subs)
        
        tab.open(URL(string: "https://google.com")!)
        XCTAssertEqual(1, tab.items.value.count)
        
        waitForExpectations(timeout: 1)
    }
    
    func testCloseNew() {
        let current = tab.selected.value
        tab.close(current)
        XCTAssertEqual(1, tab.items.value.count)
        XCTAssertNil(tab.items.value.first?.page.value)
        XCTAssertNil(tab.selected.value.page.value)
        XCTAssertEqual(tab.selected.value, tab.items.value.first)
        XCTAssertNotEqual(tab.selected.value, current)
    }
    
    func testCloseOnly() {
        let expectItems = expectation(description: "")
        let expectSelected = expectation(description: "")
        
        tab.open(URL(string: "https://google.com")!)
        
        tab.items.dropFirst(2).sink {
            XCTAssertEqual(1, $0.count)
            XCTAssertNil($0.first?.page.value)
            expectItems.fulfill()
        }.store(in: &subs)
        
        tab.selected.dropFirst().sink {
            XCTAssertNil($0.page.value)
            expectSelected.fulfill()
        }.store(in: &subs)
        
        tab.close(tab.selected.value)
        XCTAssertEqual(tab.selected.value, tab.items.value.last)
        
        waitForExpectations(timeout: 1)
    }
    
    func testClose() {
        let expectItems = expectation(description: "")
        let expectSelected = expectation(description: "")
        
        tab.open(URL(string: "https://google.com")!)
        tab.new()
        
        tab.items.dropFirst().sink {
            XCTAssertEqual(1, $0.count)
            XCTAssertEqual("https://google.com", $0.first?.page.value?.url.absoluteString)
            expectItems.fulfill()
        }.store(in: &subs)
        
        tab.selected.dropFirst().sink {
            XCTAssertEqual("https://google.com", $0.page.value?.url.absoluteString)
            expectSelected.fulfill()
        }.store(in: &subs)
        
        tab.close(tab.selected.value)
        XCTAssertEqual(tab.selected.value, tab.items.value.last)
        
        waitForExpectations(timeout: 1)
    }
}
