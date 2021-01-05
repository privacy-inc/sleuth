import Foundation

extension Ads {
    struct Rule: Hashable {
        let action: Action
        let trigger: Trigger
        
        init(_ action: Action, _ trigger: Trigger) {
            self.action = action
            self.trigger = trigger
        }
        
        func hash(into: inout Hasher) {
            into.combine(action)
            into.combine(trigger)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.action == rhs.action && lhs.trigger == rhs.trigger
        }
    }
}
