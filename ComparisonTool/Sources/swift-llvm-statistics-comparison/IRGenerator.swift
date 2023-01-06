//
//  IRGenerator.swift
//
//
//  Created by Jan-Niclas Strüwer on 15.12.22.
//

import Foundation
import Logging
import System

protocol Compiler {
    func compileToIR(_ program: Program) async throws -> CompileResult
}

struct CompileResult {
    let returnCode: Int32
    let stdOut: String?

    init(returnCode: Int32, stdOut: String? = nil) {
        self.returnCode = returnCode
        self.stdOut = stdOut
    }
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

//TODO: should we have the possibility to create one compiler for every language and
// add language specific settings as input? Or maybe have a general compiler config, including the compiler path etc.
class GeneralCompiler: Compiler {

    public enum CompilerError: Error {
        case compilerUrlNotFound(url: String)
        case compilationFailed(program: Program)
    }

    private let swiftArgs = [
        "-emit-ir", "-g", "-parse-as-library", "-Onone", "-Xfrontend", "-disable-llvm-optzns", "-Xfrontend",
        "-disable-swift-specific-llvm-optzns", "-module-name", "myModule", "-o",
    ]
    //TODO: pass clang config file to ease reuseability https://clang.llvm.org/docs/UsersManual.html#configuration-files - the -o has to be specified in the code to make the output dir configurable!
    private let cppArgs = ["-emit-llvm", "-g", "-S", "-fno-discard-value-names", "-std=c++20", "-o"]  //TODO: for openai evaluation maybe -fdiagnostics-parseable-fixits is useful to figure out, which potential errors are auto fixable by the compiler

    internal let logger = Logger(label: "com.struewer.llvm.statistics.compiler")

    internal let cppCompilerPath = "/usr/bin/clang++"
    internal let swiftcPath = "/usr/bin/swiftc"

    //TODO: add flag to optionally store the compiler output to disk
    //TODO: this is now not necessarily "compileToIr but rather, run compiler with config
    func compileToIR(_ program: Program) async throws -> CompileResult {
        self.logger.debug("compileProgram called with \(program)")

        let config = try getCompileConfig(program)
        let p = Process()

        p.executableURL = config.url
        p.arguments = config.args

        let outputPipe = Pipe()
        p.standardError = outputPipe

        try p.run()

        p.waitUntilExit()
        let returnCode = p.terminationStatus
        self.logger.info("Return code: \(returnCode)")

        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()

        if let outString = String(data: outputData, encoding: .utf8) {
            if outString != "" {
                self.logger.debug("Process output: \(outString)")
                return CompileResult(returnCode: returnCode, stdOut: outString)
            }
        }

        return CompileResult(returnCode: returnCode)
    }

    //TODO: we can't load a default config we should have this provided as an external file
    // for now we provide default configs for Swift and Cpp to be backwards compatible
    internal func getCompileConfig(_ program: Program) throws -> (url: URL, args: [String]) {
        if program.language == Program.CPP_LANGUAGE_EXTENSION {
            if let url = URL(string: cppCompilerPath) {
                return (url, getCppArgs(ProgramWithIR(p: program)))
            }
            throw CompilerError.compilerUrlNotFound(url: swiftcPath)
        } else {
            if let url = URL(string: swiftcPath) {
                return (url, getSwiftArgs(ProgramWithIR(p: program)))
            }
            throw CompilerError.compilerUrlNotFound(url: cppCompilerPath)
        }
    }

    internal func getCppArgs(_ program: ProgramWithIR) -> [String] {
        var res = cppArgs
        res.insert(program.path, at: 5)
        res.append(program.irPath)
        return res
    }

    internal func getSwiftArgs(_ program: ProgramWithIR) -> [String] {
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
        if program.language == Program.CPP_LANGUAGE_EXTENSION {
            return (URL(filePath: cppCompilerPath), getCppArgs(ProgramWithIR(p: program)))
        } else {
            return (URL(filePath: swiftcPath), getSwiftArgs(ProgramWithIR(p: program)))
        }
    }
}
