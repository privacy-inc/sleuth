import Foundation

extension Site {
    enum Partial: String, CaseIterable {
        case
        google_pagead = "/pagead/",
        google_recaptcha = "/recaptcha/",
        google_swg = "/swg/",
        youtube_embed = "/embed/",
        facebook_plugins = "/v2.2/"
        
        var domain: Allow {
            switch self {
            case .google_pagead, .google_recaptcha, .google_swg: return .google
            case .youtube_embed: return .youtube
            case .facebook_plugins: return .facebook
            }
        }
        
        var url: String {
            domain.rawValue + rawValue
        }
    }
}
