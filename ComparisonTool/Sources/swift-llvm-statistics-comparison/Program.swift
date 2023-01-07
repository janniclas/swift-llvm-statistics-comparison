//
//  Program.swift
//
//
//  Created by Jan-Niclas Strüwer on 05.01.23.
//

import Foundation

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

    private static func getProgramFromPath(_ path: String, languageExtension: String) -> Program {
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

class ProgramWithIR: BaseProgram {

    convenience init(p: Program) {
        self.init(languageExtension: p.language, name: p.name, path: p.path)
    }

    override init(languageExtension: String, name: String, path: String) {
        self.irPath = "\(path).ir.ll"
        super.init(languageExtension: languageExtension, name: name, path: path)
    }

    let irPath: String

}

class ProgramWithStatistics: ProgramWithIR {

    convenience init(p: Program, statistics: Statistics) {
        self.init(languageExtension: p.language, name: p.name, path: p.path, statistics: statistics)
    }

    init(languageExtension: String, name: String, path: String, statistics: Statistics) {
        self.statistics = statistics
        super.init(languageExtension: languageExtension, name: name, path: path)
    }

    let statistics: Statistics
}
