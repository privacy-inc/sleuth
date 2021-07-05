import Foundation

private let directory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
private let def = directory.appendingPathComponent("Sources/Tld.swift")
private let suffix = directory.appendingPathComponent("Sources/Tld.Suffix.swift")
private let dat = directory.appendingPathComponent("Tests/Tld.public_suffix_list.dat")

print(TldParser.parse(content: String(decoding: try! Data(contentsOf: dat), as: UTF8.self)))
