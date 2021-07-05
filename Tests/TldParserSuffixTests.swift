import XCTest

final class TldParserSuffixTests: XCTestCase {
    func testEmpty() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    static let suffix: [Tld : Mode] = [
        ]
}

""", TldParser.parse(content: "").suffix)
    }
}
