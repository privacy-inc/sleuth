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
    
    func testBasic() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    static let suffix: [Tld : Mode] = [
        .com : .end,
        .net : .end,
        .org : .end]
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
//abc.net
org
org
com
""").suffix)
    }
    
    func testPrevious() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    static let suffix: [Tld : Mode] = [
        .com : .end,
        .org : .previous([
            .abc : .previous([
                .tl : .end]),
            .zc8 : .end])]
}

""", TldParser.parse(content: """
org
zc8.org
org
abc.org
com
tl.abc.org
org
""").suffix)
    }
}
