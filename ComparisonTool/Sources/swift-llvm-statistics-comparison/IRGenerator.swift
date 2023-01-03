//
//  IRGenerator.swift
//
//
//  Created by Jan-Niclas Strüwer on 15.12.22.
//

import Foundation
import Logging
import System

func getPrograms(_ basePath: String) -> [String: (_: Program, _: Program?)] {

    var programDictionary: [String: (_: Program, _: Program?)] = [:]
    let fh = FileHelperFactory.getFileHelper()
    let pathDictionary = fh.getFilePaths(path: basePath, elementSuffixes: [".swift", ".cpp"])  //TODO: to increase reuse make this configurable

    for p in pathDictionary {
        let pl = p.key == ".swift" ? Program.PL.swift : Program.PL.cpp

        for path in p.value {
            let program = getProgramFromPath(path, type: pl)
            if var programTuple = programDictionary[program.name] {
                programTuple.1 = program
                programDictionary.updateValue(programTuple, forKey: program.name)
            } else {
                programDictionary[program.name] = (program, nil)
            }
        }
    }

    return programDictionary
}

private func getProgramFromPath(_ path: String, type: Program.PL) -> Program {
    let fh = FileHelperFactory.getFileHelper()
    var fileName: String

    do {
        fileName = try fh.getFileName(path: path)
    } catch {
        fileName = "invalidName_\(path)"
    }

    return Program(language: type, name: fileName, path: path)
}

protocol Compiler {
    func compileToIR(_ program: Program) async throws
}

struct CompilerFactory {

    static var compiler: Compiler?
    static func getCompiler() -> Compiler {
        if compiler != nil {
            return compiler!
        }
        #if os(macOS)
            if #available(macOS 13.0, *) {
                compiler = CompilerMacOS()
                return compiler!
            }
        #endif
        compiler = GeneralCompiler()
        return compiler!
    }
}

class GeneralCompiler: Compiler {

    public enum CompilerError: Error {
        case compilerUrlNotFound(url: String)
        case compilationFailed(program: Program)
    }

    private let swiftArgs = [
        "-emit-ir", "-g", "-parse-as-library", "-Onone", "-Xfrontend", "-disable-llvm-optzns", "-Xfrontend",
        "-disable-swift-specific-llvm-optzns", "-module-name", "myModule", "-o",
    ]
    private let cppArgs = ["-emit-llvm", "-g", "-S", "-fno-discard-value-names", "-std=c++20", "-o"]

    internal let logger = Logger(label: "com.struewer.llvm.statistics.compiler")

    internal let cppCompilerPath = "/usr/bin/clang++"
    internal let swiftcPath = "/usr/bin/swiftc"

    func compileToIR(_ program: Program) async throws {
        logger.debug("compileProgram called with \(program)")

        let config = try getCompileConfig(program)
        let p = Process()

        p.executableURL = config.url
        p.arguments = config.args

        try p.run()

        p.waitUntilExit()
    }

    internal func getCompileConfig(_ program: Program) throws -> (url: URL, args: [String]) {
        if program.language == .cpp {
            if let url = URL(string: cppCompilerPath) {
                return (url, getCppArgs(program))
            }
            throw CompilerError.compilerUrlNotFound(url: swiftcPath)
        } else {
            if let url = URL(string: swiftcPath) {
                return (url, getSwiftArgs(program))
            }
            throw CompilerError.compilerUrlNotFound(url: cppCompilerPath)
        }
    }

    internal func getCppArgs(_ program: Program) -> [String] {
        var res = cppArgs
        res.insert(program.path, at: 5)
        res.append(program.irPath)
        return res
    }

    internal func getSwiftArgs(_ program: Program) -> [String] {
        var res = swiftArgs
        res.insert(program.path, at: 10)
        res.append(program.irPath)

        return res
    }
}

@available(macOS 13.0, *)
class CompilerMacOS: GeneralCompiler {

    override init() {
        super.init()
        logger.debug("MacOS Compiler initialized")
        // TODO: add config file to inject custom paths and settings
    }

    override internal func getCompileConfig(_ program: Program) -> (url: URL, args: [String]) {
        if program.language == .cpp {
            return (URL(filePath: cppCompilerPath), getCppArgs(program))
        } else {
            return (URL(filePath: swiftcPath), getSwiftArgs(program))
        }
    }
}
