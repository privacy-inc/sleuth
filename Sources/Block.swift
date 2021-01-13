import Foundation

public struct Block {
    public static let ads = serialise(rules: [
        .init(.css(".card-ad"), .init(whitelist: .ecosia)),
        .init(.css(".card-productads"), .init(whitelist: .ecosia)),
        .init(.css("#taw"), .init(whitelist: .google)),
        .init(.css("#rhs"), .init(whitelist: .google)),
        .init(.css("#tadsb"), .init(whitelist: .google)),
        .init(.css(".commercial"), .init(whitelist: .google)),
        .init(.css(".Rn1jbe"), .init(whitelist: .google)),
        .init(.css(".kxhcC"), .init(whitelist: .google))
    ] + Wildcard.End.allCases.map {
        .init(.block, .init(end: $0))
    } + Blacklist.Https.allCases.map {
        .init(.block, .init(https: $0))
    } + Blacklist.Http.allCases.map {
        .init(.block, .init(http: $0))
    })
    
    public static let blockers = serialise(rules: [
        .init(.css("#consent-bump"), .init(whitelist: .google)),
        .init(.css("#lb"), .init(whitelist: .google)),
        .init(.css("#consent-bump"), .init(whitelist: .youtube)),
        .init(.css(".opened"), .init(whitelist: .youtube)),
        .init(.css(".ytd-popup-container"), .init(whitelist: .youtube)),
        .init(.css(".upsell-dialog-lightbox"), .init(whitelist: .youtube)),
        .init(.css(".consent-bump-lightbox"), .init(whitelist: .youtube)),
        .init(.css(".RnEpo"), .init(whitelist: .instagram)),
        .init(.css(".Yx5HN"), .init(whitelist: .instagram)),
        .init(.css("._Yhr4"), .init(whitelist: .instagram)),
        .init(.css(".R361B"), .init(whitelist: .instagram)),
        .init(.css(".NXc7H"), .init(whitelist: .instagram)),
        .init(.css(".f11OC"), .init(whitelist: .instagram)),
        .init(.css(".X6gVd"), .init(whitelist: .instagram))
    ])
    
    public static let dark = serialise(rules: [
        .init(.css(".P1Ycoe"), .init(whitelist: .google))
    ])
    
    private static func serialise(rules: [Rule]) -> String {
        rules.reduce(into: "[") {
            $0 += $0.count > 1 ? "," : ""
            $0 += "{" + .init(describing: $1.action) + "," + .init(describing: $1.trigger) + "}"
        } + "]"
    }
}
