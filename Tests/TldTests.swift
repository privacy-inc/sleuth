import XCTest
@testable import Sleuth

final class TldTests: XCTestCase {
    func testEmpty() {
        {
            XCTAssertEqual("", $0.domain)
            XCTAssertEqual("", $0.suffix)
        } (Tld.deconstruct(url: ""))
    }
    
    func testUnknown() {
        {
            XCTAssertEqual("dsfasfsdfsdfsdfasdfasd", $0.domain)
            XCTAssertEqual("", $0.suffix)
        } (Tld.deconstruct(url: "dsfasfsdfsdfsdfasdfasd"))
    }
    
    func testBasic() {
        {
            XCTAssertEqual("avocado", $0.domain)
            XCTAssertEqual(".com", $0.suffix)
        } (Tld.deconstruct(url: "www.avocado.com"))
    }
    
    func testDouble() {
        {
            XCTAssertEqual("avocado", $0.domain)
            XCTAssertEqual(".com.mx", $0.suffix)
        } (Tld.deconstruct(url: "www.aguacate.avocado.com.mx"))
    }
    
    func testWildcard() {
        {
            XCTAssertEqual("avocado", $0.domain)
            XCTAssertEqual(".chuchu.ck", $0.suffix)
        } (Tld.deconstruct(url: "www.avocado.chuchu.ck"))
    }
    
    func testException() {
        {
            XCTAssertEqual("www", $0.domain)
            XCTAssertEqual(".ck", $0.suffix)
        } (Tld.deconstruct(url: "www.avocado.www.ck"))
    }
}
