////
////  Transpiler.swift
////
////
////  Created by Jan-Niclas Strüwer on 06.02.2023.
////
//
//import Foundation
//import Logging
//import System
//
//protocol Transpiler {
//    func transpile() async throws -> TranspileResult
//}
//
//struct TranspileResult {
//    let exitCode: Int32
//    let output: String
//
//    let returnCode: Int32
//    let stdOut: String?
//
//    init(returnCode: Int32, stdOut: String? = nil) {
//        self.returnCode = returnCode
//        self.stdOut = stdOut
//
//        self.exitCode = returnCode
//        self.output = stdOut ?? ""
//    }
//}
//
//struct GeneralTranspiler: Transpiler {
//
//    public enum CompilerError: Error {
//        case compilerUrlNotFound(url: String)
//        case compilationFailed(program: Program)
//    }
//
//    init(config: TranspilerConfig) {
//        self.config = config
//    }
//
//    internal let logger = Logger(label: "com.struewer.llvm.statistics.transpiler")
//    internal let config: TranspilerConfig
//
//    func transpile() async throws -> TranspileResult {
//        self.logger.debug("transpile called with")
//
//        let p = Process()
//        let url = getURL(config.nodePath)
//        let args = getCliArguments(config: config)
//        p.executableURL = url
//        p.arguments = args  //TODO: add output file and actual program to compile:D
//
//        let outputPipe = Pipe()
//        p.standardError = outputPipe
//
//        try p.run()
//
//        p.waitUntilExit()
//        let returnCode = p.terminationStatus
//        self.logger.info("Return code: \(returnCode)")
//
//        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
//
//        if let outString = String(data: outputData, encoding: .utf8) {
//            if outString != "" {
//                self.logger.debug("Process output: \(outString)")
//                return TranspileResult(returnCode: returnCode, stdOut: outString)
//            }
//        }
//
//        return TranspileResult(returnCode: returnCode)
//    }
//
//    private func getCliArguments(config: TranspilerConfig) -> [String] {
//
////        node build/main.js --path /Users/struewer/git/openAISwiftToCpp/tests/SimpleAdd.swift --targetLanguage C++ --targetLanguageExtension .cpp --sourceLanguage Swift --sourceLanguageExtension .swift --singleFileMode --outputPath /tmp/singleFileTest
//
//        var args = [config.programPath, "--path", config.inputPath, "--targetLanguage", config.targetLanguage, "--targetLanguageExtension", config.targetLanguageExtension,"-- sourceLanguage", config.sourceLanguage, "--sourceLanguageExtension", config.sourceLanguageExtension, "--outputPath", config.outputPath ]
//        if config.singleFileMode {
//            args.append("--singleFileMode")
//        }
//
//        return args
//    }
//
//    private func getURL(_ string: String) -> URL {
//
//        //XXX: this code was removed, because it lead to faulty behavior with GitHubs MacOS 12 runners, which crashed at compile time if URL(filePath: string) was in the code, no matter if there was a runtime check
//        //        if #available(macOS 13.0, *) {
//        //            return URL(filePath: string)
//        //        } else {
//        return URL(fileURLWithPath: string)
//        //        }
//    }
//
//}
