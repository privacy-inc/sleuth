import Foundation

public struct Block {
    public static let cookies = """
[
{
    "action": {
        "type": "block-cookies"
    },
    "trigger": {
        "url-filter": ".*"
    }
}
]
"""
    
    public static let secure = """
[
{
    "action": {
        "type": "make-https"
    },
    "trigger": {
        "url-filter": ".*"
    }
}
]
"""
    
    public static let ads = serialise(rules: [
        .init(.css(".card-ad"), .init(site: .ecosia)),
        .init(.css(".card-productads"), .init(site: .ecosia)),
        .init(.css("#taw"), .init(site: .google)),
        .init(.css("#rhs"), .init(site: .google)),
        .init(.css("#tadsb"), .init(site: .google)),
        .init(.css(".commercial"), .init(site: .google)),
        .init(.css(".Rn1jbe"), .init(site: .google)),
        .init(.css(".kxhcC"), .init(site: .google))
    ] + Site.Domain.allCases.map {
        .init(.block, .init(site: $0))
    } + Site.Partial.allCases.map {
        .init(.block, .init(site: $0))
    })
    
    public static let blockers = serialise(rules: [
        .init(.css("#consent-bump"), .init(site: .google)),
        .init(.css("#lb"), .init(site: .google)),
        .init(.css("#consent-bump"), .init(site: .youtube)),
        .init(.css(".opened"), .init(site: .youtube)),
        .init(.css(".ytd-popup-container"), .init(site: .youtube)),
        .init(.css(".upsell-dialog-lightbox"), .init(site: .youtube)),
        .init(.css(".consent-bump-lightbox"), .init(site: .youtube)),
        .init(.css(".RnEpo"), .init(site: .instagram)),
        .init(.css(".Yx5HN"), .init(site: .instagram)),
        .init(.css("._Yhr4"), .init(site: .instagram)),
        .init(.css(".R361B"), .init(site: .instagram)),
        .init(.css(".NXc7H"), .init(site: .instagram)),
        .init(.css(".f11OC"), .init(site: .instagram)),
        .init(.css(".X6gVd"), .init(site: .instagram)),
        .init(.css(".css-1dbjc4n"), .init(site: .twitter)),
        .init(.css(".r-aqfbo4"), .init(site: .twitter)),
        .init(.css(".r-1p0dtai"), .init(site: .twitter)),
        .init(.css(".r-1d2f490"), .init(site: .twitter)),
        .init(.css(".r-12vffkv"), .init(site: .twitter)),
        .init(.css(".r-1xcajam"), .init(site: .twitter)),
        .init(.css(".r-zchlnj"), .init(site: .twitter))
    ])
    
    public static let dark = serialise(rules: [
        .init(.css(".P1Ycoe"), .init(site: .google))
    ])
    
    private static func serialise(rules: [Rule]) -> String {
        rules.reduce(into: "[") {
            $0 += $0.count > 1 ? "," : ""
            $0 += "{" + .init(describing: $1.action) + "," + .init(describing: $1.trigger) + "}"
        } + "]"
    }
}
