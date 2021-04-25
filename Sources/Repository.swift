import Foundation
import Combine
import Archivable

public struct Repository: Controller {
    public static let memory = Memory<Self>()
    public static let file = URL.manifest("Privacy.archive")
    public static let container = "iCloud.privacy"
    public static let prefix = "privacy_"
    public static internal(set) var override: PassthroughSubject<Archive, Never>?
}
