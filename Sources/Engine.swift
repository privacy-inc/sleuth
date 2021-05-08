import Foundation
import Archivable

public enum Engine: UInt8, Property {
    case
    ecosia,
    google
    
    public var data: Data {
        Data()
            .adding(rawValue)
    }
    
    public init(data: inout Data) {
        self.init(rawValue: data.removeFirst())!
    }
    
    var search: String {
        switch self {
        case .ecosia: return "https://www.ecosia.org/search?q="
        case .google: return "https://www.google.com/search?q="
        }
    }
}
