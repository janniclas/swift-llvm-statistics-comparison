//
//  Program.swift
//
//
//  Created by Jan-Niclas Strüwer on 05.01.23.
//

import Foundation

struct OpenAiRequest: Codable {
    let model: String
    let prompt: String
    let max_tokens: Int
    let frequency_penalty: Int
    let presence_penalty: Int
    let stop: [String]
}

struct OpenAiResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
}

struct Usage: Codable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

struct Choice: Codable {
    let text: String
    let index: Int
    let logprobs: Int?
    let finish_reason: String
}

struct InputOutputLanguage: Codable {
    let sourceLanguage: String
    let targetLanguage: String
}

protocol Program {
    var language: String { get }

    var name: String { get }
    var path: String { get }
}

extension Program {
    static var CPP_LANGUAGE_EXTENSION: String {
        return ".cpp"
    }
    static var SWIFT_LANGUAGE_EXTENSION: String {
        return ".swift"
    }
    static var JAVA_LANGUAGE_EXTENSION: String {
        return ".java"
    }
    static var KOTLIN_LANGUAGE_EXTENSION: String {
        return ".kt"
    }
}

class BaseProgram: Program {

    /// Returns a dictionary mapping language extensions to programs
    static func getProgramsFrom(
        _ basePath: String, languageExtensions: [String] = [SWIFT_LANGUAGE_EXTENSION, CPP_LANGUAGE_EXTENSION]
    ) -> [Program] {

        let fh = FileHelperFactory.getFileHelper()
        let pathDictionary = fh.getFilePaths(path: basePath, elementSuffixes: languageExtensions)

        var programs: [Program] = []

        for (language, paths) in pathDictionary {
            programs.append(contentsOf: paths.map { path in getProgramFromPath(path, languageExtension: language) })
        }

        return programs
    }

    /// Matches programs with the same name (excluding extension!) for comparison
    static func matchPrograms(programs: [Program]) -> [String: (_: Program, _: Program?)] {

        var programDictionary: [String: (_: Program, _: Program?)] = [:]

        for program in programs {
            if var pt = programDictionary[program.name] {

                pt.1 = program
                programDictionary.updateValue(pt, forKey: program.name)
            } else {
                programDictionary[program.name] = (program, nil)
            }
        }

        return programDictionary
    }

    static func getProgramFromPath(_ path: String, languageExtension: String) -> Program {
        let fh = FileHelperFactory.getFileHelper()
        var fileName: String

        do {
            fileName = try fh.getFileName(path: path)
        } catch {
            fileName = "invalidName_\(path)"
        }

        return BaseProgram(languageExtension: languageExtension, name: fileName, path: path)
    }

    let language: String

    let name: String
    let path: String

    init(languageExtension: String, name: String, path: String) {
        self.language = languageExtension
        self.name = name
        self.path = path
    }

}

class ProgramWithCompileOutput: BaseProgram {

    init(p: Program, outputPath: String) {
        self.outputPath = outputPath
        super.init(languageExtension: p.language, name: p.name, path: p.path)
    }

    let outputPath: String
}
//
//class ProgramWithStatistics: ProgramWithCompileOutput {
//
//    convenience init(p: Program, statistics: Statistics) {
//        self.init(languageExtension: p.language, name: p.name, path: p.path, statistics: statistics)
//    }
//
//    init(languageExtension: String, name: String, path: String, statistics: Statistics) {
//        self.statistics = statistics
//        super.init(languageExtension: languageExtension, name: name, path: path)
//    }
//
//    let statistics: Statistics
//}
