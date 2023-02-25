//
//  Compiler.swift
//
//
//  Created by Jan-Niclas Strüwer on 15.12.22.
//

import Foundation
import Logging

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
        self.logger.info("compileProgram called with \(program)")

        let url = URL(fileURLWithPath: config.compilerPath)
        let args = try getCompileArguments(config: config, program: program)
        let res = try await self.run(executableURL: url, args: args)
        let p = ProgramWithCompileOutput(p: program, outputPath: try getAndCreateOutputPath(config, program))
        return CompileResult(returnCode: res.exitCode, program: p, stdOut: res.output)
    }

    private func getAndCreateOutputPath(_ config: CompilerConfig, _ program: Program) throws -> String {
        let fh = FileHelperFactory.getFileHelper()
        let subdirs = fh.getDirectoryPathForFile(filePath: program.path)?.replacingOccurrences(
            of: config.inputPath, with: "")
        let dirPath = fh.appendToPath(
            basePath: config.outputPath, components: subdirs ?? "")
        if !FileManager.default.fileExists(atPath: dirPath) {
            try FileManager.default.createDirectory(
                atPath: dirPath, withIntermediateDirectories: true)
        }
        return fh.appendToPath(basePath: dirPath, components: "\(program.name)\(config.compilerOutExtension)")
    }

    private func getCompileArguments(config: CompilerConfig, program: Program) throws -> [String] {
        var args = config.compilerSettings
        let output = try getAndCreateOutputPath(config, program)

        args.append(config.compilerOutFlag)
        args.append(output)
        args.append(program.path)
        return args
    }

}
