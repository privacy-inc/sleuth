import Foundation

extension Blocker {
    struct Rule {
        let actions: [Action]
        let triggers: [Trigger]
        
        static let cookies = Self(actions: [.cookies],
                                  triggers: [.url])
        static let http = Self(actions: [.http],
                               triggers: [.url])
        
        static func css(url: URL.White, selectors: [String]) -> Self {
            .init(actions: [.css, .selector(selectors)],
                  triggers: [.url, .domain([url.rawValue + "." + url.tld.rawValue])])
        }
        
        private init(actions: [Action], triggers: [Trigger]) {
            self.actions = actions
            self.triggers = triggers
        }
    }
}
