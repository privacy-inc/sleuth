import Foundation

extension URL {
    enum White: String, Website {
        case
        ecosia = "ecosia.org",
        google = "google.com",
        youtube = "youtube.com",
        instagram = "instagram.com",
        twitter = "twitter.com",
        reuters = "reuters.com",
        thelocal = "thelocal.de",
        pinterest = "pinterest.com",
        facebook = "facebook.com",
        bbc = "bbc.com",
        reddit = "reddit.com",
        spiegel = "spiegel.de",
        snapchat = "snapchat.com",
        linkedin = "linkedin.com"
        
        var black: [Path] {
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
                return [.accounts,
                        .consent]
            default:
                return []
            }
        }
    }
}
