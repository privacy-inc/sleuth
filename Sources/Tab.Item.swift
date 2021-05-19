import WebKit

extension Tab {
    struct Item {
        let id: UUID
        let state: State
        let progress: Double
        let loading: Bool
        let forward: Bool
        let back: Bool
        let web: WKWebView?
        let snapshot: Data?
        
        init() {
            id = .init()
            state = .new
            progress = 0
            loading = false
            forward = false
            back = false
            web = nil
            snapshot = nil
        }
        
        private init(
            id: UUID,
            state: State,
            progress: Double,
            loading: Bool,
            forward: Bool,
            back: Bool,
            web: WKWebView?,
            snapshot: Data?) {
            self.id = id
            self.state = state
            self.progress = progress
            self.loading = loading
            self.forward = forward
            self.back = back
            self.web = web
            self.snapshot = snapshot
        }
        
        func with(state: State) -> Self {
            .init(id: id, state: state, progress: progress, loading: loading, forward: forward, back: back, web: web, snapshot: snapshot)
        }
        
        func with(progress: Double) -> Self {
            .init(id: id, state: state, progress: progress, loading: loading, forward: forward, back: back, web: web, snapshot: snapshot)
        }
        
        func with(loading: Bool) -> Self {
            .init(id: id, state: state, progress: progress, loading: loading, forward: forward, back: back, web: web, snapshot: snapshot)
        }
        
        func with(forward: Bool) -> Self {
            .init(id: id, state: state, progress: progress, loading: loading, forward: forward, back: back, web: web, snapshot: snapshot)
        }
        
        func with(back: Bool) -> Self {
            .init(id: id, state: state, progress: progress, loading: loading, forward: forward, back: back, web: web, snapshot: snapshot)
        }
        
        func with(web: WKWebView?) -> Self {
            .init(id: id, state: state, progress: progress, loading: loading, forward: forward, back: back, web: web, snapshot: snapshot)
        }
        
        func with(snapshot: Data?) -> Self {
            .init(id: id, state: state, progress: progress, loading: loading, forward: forward, back: back, web: web, snapshot: snapshot)
        }
    }
}
