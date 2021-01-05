import Foundation

public struct Ads {
    public static var serialise: String {
        var rules = [Rule(.css(".card-ad"), .init(whitelist: .ecosia)),
                     .init(.css(".card-productads"), .init(whitelist: .ecosia)),
                     .init(.css("#taw"), .init(whitelist: .google)),
                     .init(.css("#rhs"), .init(whitelist: .google)),
                     .init(.css("#tadsb"), .init(whitelist: .google)),
                     .init(.css("#lb"), .init(whitelist: .google)),
                     .init(.css(".commercial"), .init(whitelist: .google)),
                     .init(.css("#consent-bump"), .init(whitelist: .youtube)),
                     .init(.css(".opened"), .init(whitelist: .youtube)),
                     .init(.css(".ytd-popup-container"), .init(whitelist: .youtube))]
        
        return ""
//        return rules.reduce(into: "[") {
//            $0 += $0.count > 1 ? "," : ""
//            $0 += "{" + .init(describing: $1.action) + "," + .init(describing: $1.trigger) + "}"
//        } + "]"
    }
}
