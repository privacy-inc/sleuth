import XCTest

final class TldParserTests: XCTestCase {
    func testEmpty() {
        let result = TldParser
            .parse(content: "")
        XCTAssertEqual("""
import Foundation

public enum Tld: String {
    case
}

""", result.enum)
        XCTAssertEqual("""
import Foundation

extension Tld {
    static let suffix: [Tld : Mode] = [
        ]
}

""", result.suffix)
    }
}
