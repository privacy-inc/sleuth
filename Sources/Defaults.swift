import Foundation

public final class Defaults: UserDefaults {
    public class var archive: Archive? {
        get {
            cross.data(forKey: Key.archive.rawValue)?.prototype()
        }
        set {
            newValue.map {
                cross.setValue($0.data, forKey: Key.archive.rawValue)
            }
        }
    }
    
    public class var premium: Bool {
        get { self[.premium] as? Bool ?? false }
        set { self[.premium] = newValue }
    }
    
    public class var rated: Bool {
        get { self[.rated] as? Bool ?? false }
        set { self[.rated] = newValue }
    }
    
    public class var popups: Bool {
        get { self[.popups] as? Bool ?? true }
        set { self[.popups] = newValue }
    }
    
    public class var javascript: Bool {
        get { self[.javascript] as? Bool ?? true }
        set { self[.javascript] = newValue }
    }
    
    public class var ads: Bool {
        get { self[.ads] as? Bool ?? true }
        set { self[.ads] = newValue }
    }
    
    public class var blockers: Bool {
        get { self[.blockers] as? Bool ?? true }
        set { self[.blockers] = newValue }
    }
    
    public class var trackers: Bool {
        get { self[.trackers] as? Bool ?? true }
        set { self[.trackers] = newValue }
    }
    
    public class var cookies: Bool {
        get { self[.cookies] as? Bool ?? true }
        set { self[.cookies] = newValue }
    }
    
    public class var secure: Bool {
        get { self[.secure] as? Bool ?? true }
        set { self[.secure] = newValue }
    }
    
    public class var dark: Bool {
        get { self[.dark] as? Bool ?? true }
        set { self[.dark] = newValue }
    }
    
    public class var location: Bool {
        get { self[.location] as? Bool ?? false }
        set { self[.location] = newValue }
    }
    
    public class var engine: Engine {
        get { (self[.engine] as? String).flatMap(Engine.init(rawValue:)) ?? .google }
        set { self[.engine] = newValue.rawValue }
    }
    
    public class var created: Date? {
        get { self[.created] as? Date }
        set { self[.created] = newValue }
    }
    
    private class subscript(_ key: Key) -> Any? {
        get { standard.object(forKey: key.rawValue) }
        set { standard.setValue(newValue, forKey: key.rawValue) }
    }
    
    private static let cross = UserDefaults(suiteName: "group.incognit.share")!
}
