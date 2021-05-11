import Foundation

extension Tab {
    public struct Item {
        public let id: UUID
        public let state: State
        
        init() {
            id = .init()
            state = .new
        }
        
        private init(id: UUID, state: State) {
            self.id = id
            self.state = state
        }
        
        func with(state: State) -> Self {
            .init(id: id, state: state)
        }
    }
}
