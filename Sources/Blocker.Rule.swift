import Foundation

extension Blocker {
    struct Rule {
        let actions: [Action]
        let triggers: [Trigger]
        
        static let cookies = Self(actions: [.cookies], triggers: [.url])
        static let http = Self(actions: [.http], triggers: [.url])
        
        static func css(selectors: [String], url: URL.White) -> Self {
            .init(actions: [.css, .selector(selectors)], triggers: [.url])
        }
        
        private init(actions: [Action], triggers: [Trigger]) {
            self.actions = actions
            self.triggers = triggers
        }
    }
}
