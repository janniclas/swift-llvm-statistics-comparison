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
    let program: ProgramWithCompileOutput

    let returnCode: Int32
    let stdOut: String?

    init(returnCode: Int32, program: ProgramWithCompileOutput, stdOut: String? = nil) {
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

    init(config: CompilerConfig) {
        self.config = config
    }

    internal let config: CompilerConfig

    func compile(_ program: Program) async throws -> CompileResult {
        self.logger.debug("compileProgram called with \(program.name)")

        let url = URL(fileURLWithPath: config.compilerPath)
        let args = getCompileArguments(config: config, program: program)
        let res = try await self.run(executableURL: url, args: args)
        let p = ProgramWithCompileOutput(p: program, outputPath: getOutputPath(config, program))
        return CompileResult(returnCode: res.exitCode, program: p, stdOut: res.output)
    }

    private func getOutputPath(_ config: CompilerConfig, _ program: Program) -> String {
        return FileHelperFactory.getFileHelper().appendToPath(
            basePath: config.outputPath, components: "\(program.name)\(config.compilerOutExtension)")
    }

    private func getCompileArguments(config: CompilerConfig, program: Program) -> [String] {
        var args = config.compilerSettings
        let output = getOutputPath(config, program)

        args.append(config.compilerOutFlag)
        args.append(output)
        args.append(program.path)
        return args
    }

}
