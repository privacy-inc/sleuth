import Foundation

extension Dictionary where Key == String, Value == [Date] {
    var data: Data {
        reduce(Data()
                .adding(UInt16(count))) {
            $0
                .adding($1.key)
                .adding(UInt16($1.value.count))
                .adding($1.value.flatMap(\.data))
        }
    }
}
