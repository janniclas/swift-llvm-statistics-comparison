//
//  Compiler.swift
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
    let program: Program

    let returnCode: Int32
    let stdOut: String?

    init(returnCode: Int32, program: Program, stdOut: String? = nil) {
        self.returnCode = returnCode
        self.stdOut = stdOut
        self.program = program
    }
}

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

    func compile(_ program: Program) async throws -> CompileResult {
        self.logger.debug("compileProgram called with \(program.name)")

        let p = Process()
        let url = getURL(config.compilerPath)
        let args = getCompileArguments(config: config, program: program)
        p.executableURL = url
        p.arguments = args  //TODO: add output file and actual program to compile:D

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
                return CompileResult(returnCode: returnCode, program: program, stdOut: outString)
            }
        }

        return CompileResult(returnCode: returnCode, program: program)
    }

    private func getCompileArguments(config: Config, program: Program) -> [String] {
        var args = config.compilerSettings
        let output = FileHelperFactory.getFileHelper().appendToPath(
            basePath: config.outputPath, components: "\(program.name)\(config.compilerOutExtension)")

        args.append(config.compilerOutFlag)
        args.append(output)
        args.append(program.path)
        return args
    }

    private func getURL(_ string: String) -> URL {

        //XXX: this code was removed, because it lead to faulty behavior with GitHubs MacOS 12 runners, which crashed at compile time if URL(filePath: string) was in the code, no matter if there was a runtime check
        //        if #available(macOS 13.0, *) {
        //            return URL(filePath: string)
        //        } else {
        return URL(fileURLWithPath: string)
        //        }
    }

}
