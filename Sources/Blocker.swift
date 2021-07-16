import Foundation

enum Blocker: CaseIterable {
    case
    cookies,
    http,
    ads,
    screen,
    antidark,
    third
    
    var rules: [Rule] {
        switch self {
        case .cookies:
            return [.init(trigger: .all, action: .cookies)]
        case .http:
            return [.init(trigger: .all, action: .http)]
        case .ads:
            return [.init(trigger: .url(.ecosia), action: .css([".card-ad",
                                                                ".card-productads",
                                                                ".js-whitelist-notice",
                                                                ".callout-whitelist"])),
                    .init(trigger: .url(.google), action: .css(["#taw",
                                                                "#rhs",
                                                                "#tadsb",
                                                                ".commercial",
                                                                ".Rn1jbe",
                                                                ".kxhcC",
                                                                ".isv-r.PNCib.BC7Tfc",
                                                                ".isv-r.PNCib.o05QGe"])),
                    .init(trigger: .url(.youtube), action: .css([".ytd-search-pyv-renderer",
                                                                 ".video-ads.ytp-ad-module"])),
                    .init(trigger: .url(.bloomberg), action: .css([".leaderboard-wrapper"])),
                    .init(trigger: .url(.forbes), action: .css([".top-ad-container"]))]
        case .screen:
            return [.init(trigger: .url(.google), action: .css(["#consent-bump",
                                                                "#lb",
                                                                ".hww53CMqxtL__mobile-promo",
                                                                "#Sx9Kwc",
                                                                "#xe7COe",
                                                                ".NIoIEf",
                                                                ".QzsnAe.crIj3e",
                                                                ".ml-promotion-container"])),
                    .init(trigger: .url(.youtube), action: .css(["#consent-bump",
                                                                 ".opened",
                                                                 ".ytd-popup-container",
                                                                 ".upsell-dialog-lightbox",
                                                                 ".consent-bump-lightbox",
                                                                 "#lightbox",
                                                                 ".ytd-consent-bump-v2-renderer"])),
                    .init(trigger: .url(.instagram), action: .css([".RnEpo.Yx5HN",
                                                                   ".RnEpo._Yhr4",
                                                                   ".R361B",
                                                                   ".NXc7H.jLuN9.X6gVd",
                                                                   ".f11OC"])),
                    .init(trigger: .url(.twitter), action: .css([".css-1dbjc4n.r-aqfbo4.r-1p0dtai.r-1d2f490.r-12vffkv.r-1xcajam.r-zchlnj"])),
                    .init(trigger: .url(.reuters), action: .css(["#onetrust-consent-sdk",
                                                                 "#newReutersModal"])),
                    .init(trigger: .url(.thelocal), action: .css(["#qc-cmp2-container",
                                                                  ".tp-modal",
                                                                  ".tp-backdrop"])),
                    .init(trigger: .url(.pinterest), action: .css(
                            [".Jea.LCN.Lej.PKX._he.dxm.fev.fte.gjz.jzS.ojN.p6V.qJc.zI7.iyn.Hsu",
                             ".QLY.Rym.ZZS._he.ojN.p6V.zI7.iyn.Hsu"])),
                    .init(trigger: .url(.bbc), action: .css([".fc-consent-root",
                                                             ".ssrcss-u3tmht-ConsentBanner.exhqgzu6",
                                                             "#cookiePrompt"])),
                    .init(trigger: .url(.reddit), action: .css(["._3q-XSJ2vokDQrvdG6mR__k",
                                                                ".EUCookieNotice",
                                                                ".XPromoPopup"])),
                    .init(trigger: .url(.medium), action: .css([".lz.u.mb.ti.aj.tj.tk.tl.tm.tn.to.tp.tq.tr.ts.tt.tu.tv.tw.tx.ty.tz.ua.do.ub.uc.ud.ue.uf.ug.uh.ui.uj.uk.ul.um"])),
                    .init(trigger: .url(.bloomberg), action: .css(["#fortress-paywall-container-root",
                                                                   ".overlay-container",
                                                                   "#fortress-preblocked-container-root"])),
                    .init(trigger: .url(.forbes), action: .css(["#consent_blackbar"]))]
        case .antidark:
            return [.init(trigger: .url(.google), action: .css([".P1Ycoe"]))]
        case .third:
            return [.init(trigger: .script, action: .block)]
        }
    }
}
