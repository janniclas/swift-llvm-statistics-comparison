//
//  FileHelper.swift
//
//
//  Created by Jan-Niclas Strüwer on 22.10.22.
//

import Foundation

#if os(macOS)
    import System
#endif

enum FileHelperError: Error {
    case getFileNameFailed(path: String)
}

protocol ProcessFile {
    func appendToPath(basePath: String, components: String...) -> String
    func getFileName(path: String) throws -> String
    func getFileContents<T: Codable>(path: String, elementSuffix: String) -> [T]
    func getFilePaths(path: String, elementSuffix: String) -> [String]
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

    func getFileName(path: String) throws -> String {
        if let url = URL(string: path) {
            if url.isFileURL {
                return url.lastPathComponent
            }
        }
        throw FileHelperError.getFileNameFailed(path: path)
    }

    func getFilePaths(path: String, elementSuffix: String) -> [String] {
        var paths: [String] = []
        let enumerator = FileManager.default.enumerator(atPath: path)

        while let element = enumerator?.nextObject() as? String {

            if let fType = enumerator?.fileAttributes?[FileAttributeKey.type] as? FileAttributeType {
                // we need to check the suffix, because element is the complete path to the file
                // thus the suffix is the filename
                if fType == .typeRegular && element.hasSuffix(elementSuffix) {
                    let cPath = appendToPath(basePath: path, components: element)
                    paths.append(cPath)
                }
            }
        }
        return paths
    }

    func getFileContents<T: Codable>(path: String, elementSuffix: String) -> [T] {
        var statistics: [T] = []
        let paths = getFilePaths(path: path, elementSuffix: elementSuffix)
        for cPath in paths {
            if let stats = readContent(path: cPath) as T? {
                statistics.append(stats)
            }
        }
        return statistics
    }

    func readContent<T: Codable>(path: String) -> T? {

        if let content = FileManager.default.contents(atPath: path) {
            if let statistics = try? JSONDecoder().decode(T.self, from: content) { return statistics }
        }
        print("Expected statistics at path \(path) was not found.")
        return nil
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
