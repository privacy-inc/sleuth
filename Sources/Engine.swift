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
    
    var url: URL.White {
        switch self {
        case .ecosia: return .ecosia
        case .google: return .google
        }
    }
}
