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

    init(compileResults: [CompileResult], sourceLanguage: String, targetLanguage: String) {
        self.data = CsvData(headers: [
            "Name", "Source Language", "Target Language", "Compiler Exit Code", "Request", "Response",
            "Compiler Output",
        ])
        let encoder = JSONEncoder()
        for result in compileResults {

            let program = result.program
            var requestString: String? = nil
            var responseString: String? = nil

            if let requestResponse = try? FileHelperFactory.getFileHelper().getProgramRequestResponse(program: program)
            {
                if let jsonData = try? encoder.encode(requestResponse.request) {
                    requestString =
                        String(data: jsonData, encoding: .utf8) ?? "No request found for program \(program.name)"
                    requestString = requestString!.replacingOccurrences(of: ",", with: " ").replacingOccurrences(
                        of: "\n", with: " ")
                }
                if let jsonData = try? encoder.encode(requestResponse.response) {
                    responseString =
                        String(data: jsonData, encoding: .utf8) ?? "No request found for program \(program.name)"
                    responseString = responseString!.replacingOccurrences(of: ",", with: " ").replacingOccurrences(
                        of: "\n", with: " ")
                }
            }

            if targetLanguage != program.language {
                logger.warning(
                    "Missmatch between target language (\(targetLanguage)) and program language (\(program.language))! Expected both to match."
                )
            }

            var row = [
                program.name, sourceLanguage, targetLanguage, "\(result.returnCode)",
                requestString ?? "No request found", responseString ?? "No response found",
            ]
            if let stdOut = result.stdOut {
                let cleaned = stdOut.replacingOccurrences(of: ",", with: " ").replacingOccurrences(of: "\n", with: " ")
                row.append(cleaned)
            } else {
                row.append("No output")
            }

            self.addRow(row)
        }
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
    func getFileNameWithExtension(path: String) throws -> String
    func getFileContents<T: Codable>(path: String, elementSuffix: String) -> [T]
    func readContent<T: Codable>(path: String) throws -> T
    func getFilePaths(path: String, elementSuffix: String) -> [String]
    func getFilePaths(path: String, elementSuffixes: [String]) -> [String: [String]]
    func createOrGetOutputPath(dirPath: String, fileName: String) throws -> String
    func storeJson(dirPath: String, fileName: String, element: Codable) throws
    func getProgramRequestResponse(program: Program) throws -> (request: OpenAiRequest, response: OpenAiResponse)
    func getDirectoryPathForFile(filePath: String) -> String?
}

struct FileHelperFactory {
    static var fh: ProcessFile?
    static func getFileHelper() -> ProcessFile {
        if fh != nil {
            return fh!
        }
        #if os(macOS)
            if #available(macOS 13.0, *) {
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
                url.appendPathComponent(component)
            }
            var path = url.absoluteString
            // Decode any percent-encoded characters in the path
            if let decodedPath = path.removingPercentEncoding {
                path = decodedPath
            }
            return path
        }

        return basePath
    }

    func getProgramRequestResponse(program: Program) throws -> (request: OpenAiRequest, response: OpenAiResponse) {
        if let dirPath = URL(string: program.path)?.deletingLastPathComponent().absoluteString {
            let requestPath = self.appendToPath(basePath: dirPath, components: "\(program.name)-request.json")
            let responsePath = self.appendToPath(basePath: dirPath, components: "\(program.name)-response.json")

            let request = try self.readContent(path: requestPath) as OpenAiRequest
            let response = try self.readContent(path: responsePath) as OpenAiResponse

            return (request: request, response: response)
        }
        throw FileHelperError.FileNotFound(path: program.path)
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
        let url = URL(fileURLWithPath: path)
        if url.isFileURL {
            return url.deletingPathExtension().lastPathComponent
        }
        throw FileHelperError.getFileNameFailed(path: path)
    }

    func getFileNameWithExtension(path: String) throws -> String {
        let url = URL(fileURLWithPath: path)
        if url.isFileURL {
            return url.lastPathComponent
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
        var contents: [T] = []
        let paths = getFilePaths(path: path, elementSuffix: elementSuffix)
        for cPath in paths {
            if let content = try? readContent(path: cPath) as T {
                contents.append(content)
            }
        }
        return contents
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

    func getDirectoryPathForFile(filePath: String) -> String? {
        return URL(string: filePath)?.deletingLastPathComponent().absoluteString
    }
}

#if os(macOS)
    @available(macOS 13.0, *)
    private class FileHelperOSX: FileHelper {

        override func getDirectoryPathForFile(filePath: String) -> String? {
            return URL(string: filePath)?.deletingLastPathComponent().path()
        }

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

        override func getFileNameWithExtension(path: String) throws -> String {
            if let fileName = FilePath(path).lastComponent {
                return fileName.string
            }
            throw FileHelperError.getFileNameFailed(path: path)
        }
    }
#endif
