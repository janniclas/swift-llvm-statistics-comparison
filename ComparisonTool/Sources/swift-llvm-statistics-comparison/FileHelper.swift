//
//  FileHelper.swift
//
//
//  Created by Jan-Niclas Strüwer on 22.10.22.
//

import Foundation
import Logging

#if os(macOS)
    import System
#endif

enum FileHelperError: Error {
    case getFileNameFailed(path: String)
    case FileNotFound(path: String)
    case JsonParsingFailed(path: String)
}

struct CsvData: Codable {
    let headers: [String]
    var rows: [[String]] = []
}

struct CsvFile {

    private let logger = Logger(label: "com.struewer.llvm.statistics.CsvFile")
    private var data: CsvData

    init(headers: [String]) {
        self.data = CsvData(headers: headers)
    }

    init(compileResults: [CompileResult]) {
        self.data = CsvData(headers: ["Name", "Language", "Compiler Exit Code", "Compiler Output"])
        for result in compileResults {
            var row = [result.program.name, result.program.language, "\(result.returnCode)"]
            if let stdOut = result.stdOut {
                let cleaned = stdOut.replacingOccurrences(of: ",", with: " ").replacingOccurrences(of: "\n", with: " ")
                row.append(cleaned)
            } else {
                row.append("No output")
            }

            self.addRow(row)
        }
    }

    mutating func addRow(_ row: [String]) {
        if row.count == data.headers.count {
            data.rows.append(row)
        } else {
            logger.error("Add row failed. Number of columns doesn't match number of headers.")
        }
    }

    func storeData(path: String) throws {
        var csvString = rowToCsvString(data.headers)
        for row in data.rows {
            csvString += rowToCsvString(row)
        }
        let outputPath = try FileHelperFactory.getFileHelper().createOrGetOutputPath(
            dirPath: path, fileName: "results.csv")
        let url = URL(fileURLWithPath: outputPath)
        try csvString.write(to: url, atomically: true, encoding: .utf8)
    }

    private func rowToCsvString(_ row: [String]) -> String {
        var csvString = row.reduce(
            "",
            {
                acc, next in
                if acc == "" {
                    return "\(next)"
                } else {
                    return "\(acc),\(next)"
                }
            })
        csvString += " \n"

        return csvString
    }
}

protocol ProcessFile {
    func appendToPath(basePath: String, components: String...) -> String
    func getFileName(path: String) throws -> String
    func getFileContents<T: Codable>(path: String, elementSuffix: String) -> [T]
    func readContent<T: Codable>(path: String) throws -> T
    func getFilePaths(path: String, elementSuffix: String) -> [String]
    func getFilePaths(path: String, elementSuffixes: [String]) -> [String: [String]]
    func createOrGetOutputPath(dirPath: String, fileName: String) throws -> String
    func storeJson(dirPath: String, fileName: String, element: Codable) throws
}

struct FileHelperFactory {
    static var fh: ProcessFile?
    static func getFileHelper() -> ProcessFile {
        if fh != nil {
            return fh!
        }
        #if os(macOS)
            if #available(macOS 12.0, *) {
                fh = FileHelperOSX()
                return fh!
            }
        #endif
        fh = FileHelper()
        return fh!
    }
}

private class FileHelper: ProcessFile {

    private let logger = Logger(label: "com.struewer.llvm.statistics.fileHelper")
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        encoder.outputFormatting = .prettyPrinted
    }
    /// If append fails or missbehaves it returns basePath.
    func appendToPath(basePath: String, components: String...) -> String {
        if var url = URL(string: basePath) {
            for component in components {
                url = url.appendingPathExtension(component)
            }
            return url.path
        }

        return basePath
    }

    /// Stores given element at dirPath. Creates directories if non existend.
    func storeJson(dirPath: String, fileName: String, element: Codable) throws {

        let fileOutput = try createOrGetOutputPath(dirPath: dirPath, fileName: fileName)

        FileManager.default.createFile(atPath: fileOutput, contents: try encoder.encode(element))

        logger.info("File was saved to \(fileOutput)")
    }

    /// Creates directories or files if non existend.
    func createOrGetOutputPath(dirPath: String, fileName: String) throws -> String {
        if !FileManager.default.fileExists(atPath: dirPath) {
            try FileManager.default.createDirectory(
                atPath: dirPath, withIntermediateDirectories: true)
        }

        return appendToPath(
            basePath: dirPath, components: fileName)
    }

    func getFileName(path: String) throws -> String {
        if let url = URL(string: path) {
            if url.isFileURL {
                return url.lastPathComponent
            }
        }
        throw FileHelperError.getFileNameFailed(path: path)
    }

    func getFilePaths(path: String, elementSuffix: String) -> [String] {
        let pathDict = getFilePaths(path: path, elementSuffixes: [elementSuffix])
        if let paths = pathDict[elementSuffix] {
            return paths
        } else {
            return []
        }
    }

    /// Searches for all files with the given suffixes.
    /// Returns a dictionary mapping the element suffix to the found programs.
    func getFilePaths(path: String, elementSuffixes: [String]) -> [String: [String]] {
        var pathsDict: [String: [String]] = [:]
        let enumerator = FileManager.default.enumerator(atPath: path)

        while let element = enumerator?.nextObject() as? String {

            if let fType = enumerator?.fileAttributes?[FileAttributeKey.type] as? FileAttributeType {
                // we need to check the suffix, because element is the complete path to the file
                // thus the suffix is the filename
                if fType == .typeRegular {
                    for elementSuffix in elementSuffixes {
                        if element.hasSuffix(elementSuffix) {
                            let cPath = appendToPath(basePath: path, components: element)
                            if var paths = pathsDict[elementSuffix] {
                                paths.append(cPath)
                                pathsDict.updateValue(paths, forKey: elementSuffix)
                            } else {
                                pathsDict[elementSuffix] = [cPath]
                            }
                            break
                        }
                    }
                }
            }
        }
        return pathsDict
    }

    func getFileContents<T: Codable>(path: String, elementSuffix: String) -> [T] {
        var statistics: [T] = []
        let paths = getFilePaths(path: path, elementSuffix: elementSuffix)
        for cPath in paths {
            if let stats = try? readContent(path: cPath) as T {
                statistics.append(stats)
            }
        }
        return statistics
    }

    func readContent<T: Codable>(path: String) throws -> T {

        if let content = FileManager.default.contents(atPath: path) {
            if let json = try? decoder.decode(T.self, from: content) {
                return json
            } else {
                self.logger.error("Decoding of file at path \(path) failed.")
                throw FileHelperError.JsonParsingFailed(path: path)
            }
        } else {
            self.logger.error("Expected file at path \(path) was not found.")
            throw FileHelperError.FileNotFound(path: path)
        }
    }
}

#if os(macOS)
    @available(macOS 12.0, *)
    private class FileHelperOSX: FileHelper {

        /// If append fails or missbehaves it returns basePath.
        override func appendToPath(basePath: String, components: String...) -> String {
            var fp = FilePath(basePath)
            for component in components {
                fp.append(component)
            }
            return fp.string
        }

        override func getFileName(path: String) throws -> String {
            if let fileName = FilePath(path).lastComponent {
                return fileName.stem
            }

            throw FileHelperError.getFileNameFailed(path: path)
        }
    }
#endif
