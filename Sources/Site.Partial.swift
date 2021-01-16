import Foundation

extension Site {
    enum Partial: String, CaseIterable {
        case
        google_pagead = "/pagead/",
        google_recaptcha = "/recaptcha/",
        youtube_embed = "/embed/"
        
        var domain: Allow {
            switch self {
            case .google_pagead, .google_recaptcha: return .google
            case .youtube_embed: return .youtube
            }
        }
        
        var url: String {
            domain.rawValue + rawValue
        }
    }
}
