import Foundation

extension Blocker {
    struct Rule {
        let actions: [Action]
        let triggers: [Trigger]
        
        static let cookies = Self(actions: [.cookies],
                                  triggers: [.all])
        static let http = Self(actions: [.http],
                               triggers: [.all])
        
        static func css(url: URL.White, selectors: [String]) -> Self {
            .init(actions: [.css, .selector(selectors)],
                  triggers: [.all, .domain(url)])
        }
        
        private init(actions: [Action], triggers: [Trigger]) {
            self.actions = actions
            self.triggers = triggers
        }
    }
}
