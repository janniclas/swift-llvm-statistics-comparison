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

class GeneralCompiler: ExternalProgram, Compiler {

    public enum CompilerError: Error {
        case compilerUrlNotFound(url: String)
        case compilationFailed(program: Program)
    }

    init(config: Config) {
        self.config = config
    }

    internal let config: Config

    func compile(_ program: Program) async throws -> CompileResult {
        self.logger.debug("compileProgram called with \(program.name)")

        let url = URL(fileURLWithPath: config.compilerPath)
        let args = getCompileArguments(config: config, program: program)
        let res = try await self.run(executableURL: url, args: args)

        return CompileResult(returnCode: res.exitCode, program: program, stdOut: res.output)
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

}
