//
//  FileHelper.swift
//
//
//  Created by Jan-Niclas Strüwer on 22.10.22.
//

import Foundation
import System

enum FileHelperError: Error {
  case getFileNameFailed(path: String)
}

/// If append fails or missbehaves it returns basePath.
func appendToPath(basePath: String, components: String...) -> String {
  if #available(macOS 12.0, *) {
    var fp = FilePath(basePath)
    for component in components {
      fp.append(component)
    }
    return fp.string
  } else {
    var url = URL(string: basePath)
    if url != nil {
      for component in components {
        url = url?.appendingPathExtension(component)
      }
      return url!.path
    }
  }
  return basePath
}

func getFileName(path: String) throws -> String {
  if #available(macOS 12.0, *) {
    if let fileName = FilePath(path).lastComponent {
      return fileName.stem
    }
  } else {
    let url = URL(string: path)
    if url != nil && url!.isFileURL {
      return url!.lastPathComponent
    }
  }
  throw FileHelperError.getFileNameFailed(path: path)
}

func getFileContents<T: Codable>(path: String, elementSuffix: String) -> [T] {
  var statistics: [T] = []
  let enumerator = FileManager.default.enumerator(atPath: path)

  while let element = enumerator?.nextObject() as? String {

    if let fType = enumerator?.fileAttributes?[FileAttributeKey.type] as? FileAttributeType {
      // we need to check the suffix, because element is the complete path to the file
      // thus the suffix is the filename
      if fType == .typeRegular && element.hasSuffix(elementSuffix) {
        let cPath = appendToPath(basePath: path, components: element)
        if let stats = readContent(path: cPath) as T? {
          statistics.append(stats)
        }
      }
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
