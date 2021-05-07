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
    
    private var rules: [Rule] {
        switch self {
        case .cookies:
            return [.init(trigger: .all, action: .cookies)]
        case .http:
            return [.init(trigger: .all, action: .http)]
        case .ads:
            return [.init(trigger: .url(.ecosia), action: .css([".card-ad",
                                                                ".card-productads"])),
                    .init(trigger: .url(.google), action: .css(["#taw",
                                                                "#rhs",
                                                                "#tadsb",
                                                                ".commercial",
                                                                ".Rn1jbe",
                                                                ".kxhcC",
                                                                ".isv-r.PNCib.BC7Tfc",
                                                                ".isv-r.PNCib.o05QGe"]))]
        case .popups:
            return []
        case .antidark:
            return []
        }
    }
}
