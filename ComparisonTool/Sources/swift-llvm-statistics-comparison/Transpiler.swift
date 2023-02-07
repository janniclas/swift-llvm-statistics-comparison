//
//  Transpiler.swift
//
//
//  Created by Jan-Niclas Strüwer on 15.12.22.
//

import Foundation
import Logging
import System

struct TranspileResult {
    let externalProgramResult: ExternalProgramResult
    let outputPath: String
}

struct CombinedResults {
    let transpileResult: TranspileResult
    let compileResult: CompileResult
    let numberOfTries: UInt8
}

class GeneralTranspiler: ExternalProgram {

    func transpile(config: TranspilerConfig) async throws -> TranspileResult {
        let args = getCliArguments(config: config)
        let url = URL(fileURLWithPath: config.nodePath)

        let res = try await self.run(executableURL: url, args: args)

        return TranspileResult(externalProgramResult: res, outputPath: config.outputPath)
    }

    private func getCliArguments(config: TranspilerConfig) -> [String] {

        //        node build/main.js --path /Users/struewer/git/openAISwiftToCpp/tests/SimpleAdd.swift --targetLanguage C++ --targetLanguageExtension .cpp --sourceLanguage Swift --sourceLanguageExtension .swift --singleFileMode --outputPath /tmp/singleFileTest

        var args = [
            config.programPath, "--path", config.inputPath, "--targetLanguage", config.targetLanguage,
            "--targetLanguageExtension", config.targetLanguageExtension, "--sourceLanguage", config.sourceLanguage,
            "--sourceLanguageExtension", config.sourceLanguageExtension, "--outputPath", config.outputPath, "--envPath",
            config.envPath,
        ]
        if config.singleFileMode {
            args.append("--singleFileMode")
        }

        return args
    }

}
