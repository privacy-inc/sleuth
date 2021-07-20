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
        favicon.load(domain: "lorem")
        
        favicon
            .icons
            .dropFirst()
            .sink { _ in
                XCTFail()
            }
            .store(in: &subs)
    }
    
    func testLoadKnown() {
        let expect = expectation(description: "")
        let data = Data("lorem ipsum".utf8)
        
        favicon
            .icons
            .compactMap {
                $0["tulum"]
            }
            .sink {
                XCTAssertEqual(Thread.main, Thread.current)
                XCTAssertEqual(data, $0)
                expect.fulfill()
            }
            .store(in: &subs)
        
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("icons")
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        try! data.write(to: folder.appendingPathComponent("tulum"), options: .atomic)
        
        DispatchQueue
            .global(qos: .utility)
            .async {
                self.favicon.load(domain: "tulum")
            }
        
        waitForExpectations(timeout: 1)
    }
    
    func testLoadDouble() {
        let expect = expectation(description: "")
        let data1 = Data("lorem ipsum1".utf8)
        let data2 = Data("lorem ipsum2".utf8)
        
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("icons")
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        try! data1.write(to: folder.appendingPathComponent("holbox"), options: .atomic)
        
        favicon
            .icons
            .compactMap {
                $0["holbox"]
            }
            .sink {
                XCTAssertEqual(data1, $0)
                try! data2.write(to: folder.appendingPathComponent("holbox"), options: .atomic)
                self.favicon.load(domain: "holbox")
                expect.fulfill()
            }
            .store(in: &subs)
        
        favicon.load(domain: "holbox")
        
        waitForExpectations(timeout: 1)
    }
    
    func testSave() {
        let expect = expectation(description: "")
        let data = Data("hello world".utf8)
        
        favicon
            .icons
            .compactMap {
                $0["aguacate"]
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
