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
    _0 = "0",
    _1hello_world = "1hello-world",
    abc,
    _as = "as",
    _case = "case",
    com,
    _do = "do",
    _for = "for",
    hello_world = "hello-world",
    _if = "if",
    _in = "in",
    net,
    org,
    _static = "static"
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
org.abc
net
abc.net
org
org
0.com
as
case
do
static
for
if
in
hello-world.com
1hello-world.com
com
""").enum)
    }
    
    func testWildcard() {
        XCTAssertEqual("""
import Foundation

public enum Tld: String {
    case
    ck
}

""", TldParser.parse(content: """
*.ck
""").enum)
    }
    
    func testException() {
        XCTAssertEqual("""
import Foundation

public enum Tld: String {
    case
    ck,
    www
}

""", TldParser.parse(content: """
!www.ck
""").enum)
    }
}
