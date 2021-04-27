import Foundation
import Combine
import Archivable

public struct Repository: Controller {
    public typealias A = Archive
    
    public static let memory = Cloud<Self>()
    public static let file = URL.manifest("Privacy.archive")
    public static let container = "iCloud.privacy"
    public static let prefix = "privacy_"
}
