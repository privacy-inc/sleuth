import Foundation

extension Site {
    enum Partial: String, CaseIterable {
        case
        google_pagead = "/pagead/",
        google_recaptcha = "/recaptcha/",
        google_swg = "/swg/",
        youtube_embed = "/embed/",
        facebook_plugins = "/v2.2/",
        reddit_account = "/account/"
        
        var domain: Allow {
            switch self {
            case .google_pagead, .google_recaptcha, .google_swg: return .google
            case .youtube_embed: return .youtube
            case .facebook_plugins: return .facebook
            case .reddit_account: return .reddit
            }
        }
        
        var url: String {
            domain.rawValue + rawValue
        }
    }
}
