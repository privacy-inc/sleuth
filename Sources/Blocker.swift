import Foundation

public enum Blocker: CaseIterable {
    case
    cookies,
    http,
    ads,
    popups,
    antidark
    
    public static func rules(_ types: Set<Self>) -> String {
        types
            .flatMap(\.rules)
            .content
    }
    
    public var content: String {
        rules.content
    }
    
    private var rules: [Rule] {
        switch self {
        case .cookies:
            return [.cookies]
        case .http:
            return [.http]
        case .ads:
            return [.css(url: .ecosia, selectors: [".card-ad",
                                                   ".card-productads"]),
                    .css(url: .google, selectors: ["#taw",
                                                   "#rhs",
                                                   "#tadsb",
                                                   ".commercial",
                                                   ".Rn1jbe",
                                                   ".kxhcC",
                                                   ".isv-r.PNCib.BC7Tfc",
                                                   ".isv-r.PNCib.o05QGe"])]
        case .popups:
            return []
        case .antidark:
            return []
        }
    }
}
