//
//  Config.swift
//
//
//  Created by Jan-Niclas Strüwer on 07.01.23.
//

import Foundation

func loadConfig<T: Codable>(path: String) throws -> T {
    let fh = FileHelperFactory.getFileHelper()

    return try fh.readContent(path: path) as T
}

struct Config: Codable {

    let compilerPath: String
    let compilerSettings: [String]
    let languageExtension: String

    let compilerOutFlag: String
    let compilerOutExtension: String

    let outputPath: String
    let inputPath: String
}

struct TranspileModeConfig: Codable {

    let transpilerConfig: TranspilerConfig

    let compilerPath: String
    let compilerSettings: [String]
    let compilerOutFlag: String
    let compilerOutExtension: String
}

struct TranspilerConfig: Codable {

    // Config related to QT
    let targetLanguage: String
    let targetLanguageExtension: String
    let sourceLanguage: String
    let sourceLanguageExtension: String

    let inputPath: String
    let outputPath: String

    let nodePath: String
    let programPath: String
    let singleFileMode: Bool
}
