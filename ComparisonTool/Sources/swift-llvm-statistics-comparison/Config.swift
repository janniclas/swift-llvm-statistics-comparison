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

struct DiffConfig: Codable {
    let firstLanguage: CompilerConfig
    let secondLanguage: CompilerConfig
    let dockerConfig: DockerConfig
    let outputPath: String
}

struct DockerConfig: Codable {
    let dockerPath: String
    let phasarImage: String
}

struct CompilerConfig: Codable {

    let compilerPath: String
    let compilerSettings: [String]
    let languageExtension: String

    let compilerOutFlag: String
    let compilerOutExtension: String

    let outputPath: String
    let inputPath: String
}

struct TranspileModeConfig: Codable {
    let compilerPath: String
    let compilerSettings: [String]
    let compilerOutFlag: String
    let compilerOutExtension: String

    // Config related to QT
    let outputPath: String
    let inputPath: String

    let targetLanguage: String
    let targetLanguageExtension: String
    let sourceLanguage: String
    let sourceLanguageExtension: String

    let nodePath: String
    let programPath: String
    let envPath: String
}

struct TranspilerConfig: Codable {

    init(_ config: TranspileModeConfig, singleFileMode: Bool) {
        self.envPath = config.envPath
        self.inputPath = config.inputPath
        self.outputPath = config.outputPath
        self.targetLanguage = config.targetLanguage
        self.sourceLanguage = config.sourceLanguage
        self.targetLanguageExtension = config.targetLanguageExtension
        self.sourceLanguageExtension = config.sourceLanguageExtension
        self.nodePath = config.nodePath
        self.singleFileMode = singleFileMode
        self.programPath = config.programPath
    }

    init(_ config: TranspileModeConfig, inputPath: String, outputPath: String, singleFileMode: Bool) {
        self.envPath = config.envPath
        self.inputPath = inputPath
        self.outputPath = outputPath
        self.targetLanguage = config.targetLanguage
        self.sourceLanguage = config.sourceLanguage
        self.targetLanguageExtension = config.targetLanguageExtension
        self.sourceLanguageExtension = config.sourceLanguageExtension
        self.nodePath = config.nodePath
        self.singleFileMode = singleFileMode
        self.programPath = config.programPath
    }

    let envPath: String
    // Config related to QT
    let outputPath: String
    let inputPath: String

    let targetLanguage: String
    let targetLanguageExtension: String
    let sourceLanguage: String
    let sourceLanguageExtension: String

    let nodePath: String
    let programPath: String
    let singleFileMode: Bool
}
