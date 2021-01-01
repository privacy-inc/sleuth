import Foundation

public final class Shared: UserDefaults {
    private static let defaults = UserDefaults(suiteName: "group.incognit.share")!
    
    public class var history: [Item] {
        get {
            (self[.history] as? Data).flatMap { try? JSONDecoder().decode([Item].self, from: $0) } ?? []
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
    
    private class subscript(_ key: Key) -> Any? {
        get { defaults.object(forKey: key.rawValue) }
        set { defaults.setValue(newValue, forKey: key.rawValue) }
    }
}
