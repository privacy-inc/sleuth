import Foundation

extension Legacy {
    public final class Share: UserDefaults {
        public static let store = UserDefaults(suiteName: "group.incognit.share")!
        
        public class var history: [Page] {
            get {
                (self[.history] as? Data).flatMap { try? JSONDecoder().decode([Page].self, from: $0) } ?? []
            }
            set {
                (try? JSONEncoder().encode(newValue)).map {
                    self[.history] = $0
                }
            }
        }
        
        public class var chart: [Date] {
            get { self[.chart] as? [Date] ?? [] }
            set { self[.chart] = newValue }
        }
        
        public class var blocked: [String] {
            get { self[.blocked] as? [String] ?? [] }
            set { self[.blocked] = newValue }
        }
        
        private class subscript(_ key: Key) -> Any? {
            get { store.object(forKey: key.rawValue) }
            set { store.setValue(newValue, forKey: key.rawValue) }
        }
    }
}
