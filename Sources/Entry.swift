import Foundation
import Archivable

public enum Entry {
    case
    remote(Page),
    local(Page, Data)
}
