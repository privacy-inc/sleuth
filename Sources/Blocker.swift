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
//            return [.init(trigger: .url(<#T##URL.White#>), action: <#T##Rule.Action#>)]
            return []
        case .antidark:
            return []
        }
    }
}


/*
public static let blockers = serialise(rules: [
    .init(.css("#consent-bump"), .init(site: .google)),
    .init(.css("#lb"), .init(site: .google)),
    .init(.css(".hww53CMqxtL__mobile-promo"), .init(site: .google)),
    .init(.css("#Sx9Kwc"), .init(site: .google)),
    .init(.css("#consent-bump"), .init(site: .youtube)),
    .init(.css(".opened"), .init(site: .youtube)),
    .init(.css(".ytd-popup-container"), .init(site: .youtube)),
    .init(.css(".upsell-dialog-lightbox"), .init(site: .youtube)),
    .init(.css(".consent-bump-lightbox"), .init(site: .youtube)),
    .init(.css(".RnEpo.Yx5HN"), .init(site: .instagram)),
    .init(.css(".RnEpo._Yhr4"), .init(site: .instagram)),
    .init(.css(".R361B"), .init(site: .instagram)),
    .init(.css(".NXc7H.jLuN9.X6gVd"), .init(site: .instagram)),
    .init(.css(".f11OC"), .init(site: .instagram)),
    .init(.css(".css-1dbjc4n.r-aqfbo4.r-1p0dtai.r-1d2f490.r-12vffkv.r-1xcajam.r-zchlnj"), .init(site: .twitter)),
    .init(.css("#onetrust-consent-sdk"), .init(site: .reuters)),
    .init(.css("#newReutersModal"), .init(site: .reuters)),
    .init(.css("#qc-cmp2-container"), .init(site: .thelocal)),
    .init(.css(".tp-modal"), .init(site: .thelocal)),
    .init(.css(".tp-backdrop"), .init(site: .thelocal)),
    .init(.css(".Jea.LCN.Lej.PKX._he.dxm.fev.fte.gjz.jzS.ojN.p6V.qJc.zI7.iyn.Hsu"), .init(site: .pinterest)),
    .init(.css(".QLY.Rym.ZZS._he.ojN.p6V.zI7.iyn.Hsu"), .init(site: .pinterest)),
    .init(.css(".fc-consent-root"), .init(site: .bbc)),
    .init(.css(".ssrcss-u3tmht-ConsentBanner.exhqgzu6"), .init(site: .bbc)),
    .init(.css("#cookiePrompt"), .init(site: .bbc)),
    .init(.css("._3q-XSJ2vokDQrvdG6mR__k"), .init(site: .reddit)),
    .init(.css(".EUCookieNotice"), .init(site: .reddit)),
    .init(.css(".XPromoPopup"), .init(site: .reddit))
])
*/
