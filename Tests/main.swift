import Foundation

private let directory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
private let def = directory.appendingPathComponent("Sources/Tld.swift")
private let suffix = directory.appendingPathComponent("Sources/Tld.Suffix.swift")
private let dat = directory.appendingPathComponent("Tests/Tld.public_suffix_list.dat")

let result = TldParser
    .parse(content: String(decoding: try! Data(contentsOf: dat), as: UTF8.self))
try! Data(result
        .enum
        .utf8)
    .write(to: def, options: .atomic)
//try! Data(result
//        .suffix
//        .utf8)
//    .write(to: suffix, options: .atomic)

print("Updated enum and suffix!")
