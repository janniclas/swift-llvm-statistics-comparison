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
    func compile(_ program: Program) async throws -> CompileResult
}

struct CompileResult {
    let returnCode: Int32
    let stdOut: String?

    init(returnCode: Int32, stdOut: String? = nil) {
        self.returnCode = returnCode
        self.stdOut = stdOut
    }
}

//TODO: should we have the possibility to create one compiler for every language and
// add language specific settings as input? Or maybe have a general compiler config, including the compiler path etc.
struct GeneralCompiler: Compiler {

    public enum CompilerError: Error {
        case compilerUrlNotFound(url: String)
        case compilationFailed(program: Program)
    }
    
    init(config: Config) {
        self.config = config
    }


    internal let logger = Logger(label: "com.struewer.llvm.statistics.compiler")
    internal let config: Config

    //TODO: add flag to optionally store the compiler output to disk
    //TODO: this is now not necessarily "compileToIr but rather, run compiler with config
    func compile(_ program: Program) async throws -> CompileResult {
        self.logger.debug("compileProgram called with \(program.name)")

        let p = Process()
        let url = getURL(config.compilerPath)

        p.executableURL = url
        p.arguments = config.compilerSettings

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
    
    private func getURL(_ string: String)-> URL {
        if #available(macOS 13.0, *) {
            return URL(filePath: string)
        } else {
            return URL(fileURLWithPath: string)
        }
    }


}
