import XCTest

final class TldParserEnumTests: XCTestCase {
    func testEmpty() {
        XCTAssertEqual("""
import Foundation

public enum Tld: String {
    case
    \

}

""", TldParser.parse(content: "").enum)
    }
    
    func testBasic() {
        XCTAssertEqual("""
import Foundation

public enum Tld: String {
    case
    com,
    net,
    org
}

""", TldParser.parse(content: """
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// Please pull this list from, and only from https://publicsuffix.org/list/public_suffix_list.dat,
// rather than any other VCS sites. Pulling from any other URL is not guaranteed to be supported.

// Instructions on pulling and using this list can be found at https://publicsuffix.org/list/.

// ===BEGIN ICANN DOMAINS===

// ac : https://en.wikipedia.org/wiki/.ac
org
net
org
org
com
""").enum)
    }
}
