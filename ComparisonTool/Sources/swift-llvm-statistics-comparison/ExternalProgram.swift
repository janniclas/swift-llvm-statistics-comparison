//
//  Transpiler.swift
//
//
//  Created by Jan-Niclas Strüwer on 06.02.2023.
//

import Foundation
import Logging
import System

struct ExternalProgramResult {
    let exitCode: Int32
    let output: String
}

class ExternalProgram {
    internal let logger = Logger(label: "com.struewer.llvm.statistics.externalProgram")
    func run(executableURL: URL, args: [String]) async throws -> ExternalProgramResult {
        self.logger.debug("External program \(executableURL.absoluteString) called with args \(args)")

        let p = Process()

        p.executableURL = executableURL
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
                return ExternalProgramResult(exitCode: returnCode, output: outString)
            }
        }

        return ExternalProgramResult(exitCode: returnCode, output: "No output generated")
    }
}