import Foundation

extension URL {
    enum White: String, CaseIterable {
        case
        ecosia,
        google,
        youtube,
        instagram,
        twitter,
        reuters,
        thelocal,
        pinterest,
        facebook,
        bbc,
        reddit,
        spiegel,
        snapchat,
        linkedin,
        nyt
        
        var tld: TLD {
            switch self {
            case .ecosia:
                return .org
            case .google:
                return .com
            case .youtube:
                return .com
            case .instagram:
                return .com
            case .twitter:
                return .com
            case .reuters:
                return .com
            case .thelocal:
                return .de
            case .pinterest:
                return .com
            case .facebook:
                return .com
            case .bbc:
                return .com
            case .reddit:
                return .com
            case .spiegel:
                return .de
            case .snapchat:
                return .com
            case .linkedin:
                return .com
            case .nyt:
                return .com
            }
        }
        
        var path: [Path] {
            switch self {
            case .google:
                return [.pagead,
                        .recaptcha,
                        .swg]
            case .youtube:
                return [.embed]
            case .facebook:
                return [.plugins]
            case .reddit:
                return [.account]
            case .nyt:
                return [.ads]
            default:
                return []
            }
        }
        
        var subdomain: [Subdomain] {
            switch self {
            case .twitter:
                return [.platform]
            case .spiegel:
                return [.interactive]
            case .snapchat:
                return [.tr]
            case .linkedin:
                return [.platform]
            case .google:
                return [.accounts]
            default:
                return []
            }
        }
    }
}
