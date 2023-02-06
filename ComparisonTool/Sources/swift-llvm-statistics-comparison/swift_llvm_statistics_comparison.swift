import ArgumentParser
import Foundation
import Logging

#if os(macOS)
    import System

    enum Mode: String, ExpressibleByArgument {
        case diff, compile, transpile
    }

    @main
    @available(macOS 13.0, *)
    struct swift_llvm_statistics_comparison: AsyncParsableCommand {
        @Argument(help: "Which mode to run. Curent valid modes diff and compile.")
        var mode: Mode

        @Option(help: "Config file with paths to executables and compiler configs.")
        var config: String
    }

    @available(macOS 13.0, *)
    extension swift_llvm_statistics_comparison {

        mutating func run() async throws {
            LoggingSystem.bootstrap(UnifiedLogger.init)

            switch mode {
            case .diff:
                let diffAndCompileConfig = try loadConfig(path: config) as CompilerConfig
                try await startDiff(config: diffAndCompileConfig)
            case .compile:
                let diffAndCompileConfig = try loadConfig(path: config) as CompilerConfig
                try await startCompiler(config: diffAndCompileConfig)
            case .transpile:
                let transConfig = try loadConfig(path: config) as TranspileModeConfig
                try await transpile(config: transConfig)
            }

        }
    }
#endif
#if os(Linux)

    enum Mode: String {
        case diff, compile
    }

    enum ArgError: Error {
        case unkownArgument(arg: String)
    }

    @main
    struct swift_llvm_statistics_comparison {
        static func main() async throws {
            let args = try getPath(args: CommandLine.arguments)

            switch args.mode {
            case .diff:
                let config = try loadConfig(path: args.path) as Config
                try await startDiff(config: config)
            case .compile:
                let config = try loadConfig(path: args.path) as Config
                try await startCompiler(config: config)
            case .transpile:
                let config = try loadConfig(path: args.path) as TranspileModeConfig
                try await transpile(config: config)
            }
        }
    }

    func getPath(args: [String]) throws -> (mode: Mode, path: String) {
        var mode: Mode
        for index in 1..<args.count {
            let argument = args[index]
            switch argument {
            case .diff:
                mode = .diff
            case .compile:
                mode = .compile
            case "--config":
                if index + 1 < args.count {
                    p = args[index + 1]
                    break
                }
            default:
                throw ArgError.unkownArgument(arg: argument)
            }
        }
        return (mode, p)
    }
#endif

func startDiff(config: CompilerConfig) async throws {
    let logger = Logger(label: "com.struewer.llvm.statistics")
    logger.info("Started to run in diff mode. Input path \(config.inputPath)")
    let diffCalc = DiffCalculator(basePath: config.inputPath)
    try diffCalc.run()
}

func transpile(config: TranspileModeConfig) async throws {

    //TODO: Multiple reruns have to have different output directories so we don't accidently
    // override files
    let transpilerConfig = TranspilerConfig(config, singleFileMode: false)
    try await startBatchTranspilation(transpilerConfig)

    let compilerConfig = CompilerConfig(
        compilerPath: config.compilerPath, compilerSettings: config.compilerSettings,
        languageExtension: config.targetLanguageExtension, compilerOutFlag: config.compilerOutFlag,
        compilerOutExtension: config.compilerOutExtension, outputPath: config.outputPath, inputPath: config.outputPath)

    let batchCompileResult = try await startCompiler(config: compilerConfig)
    let failedPrograms = batchCompileResult.filter { result in
        result.returnCode != 0
    }
    //TODO: figure out how to map failed programs to original input programs
    //idea: maybe batch compiling isn't the way to go
    // take initial dir as input, look for all files (reuse fuctionality from batch compiling)
    // process files one by one and directly retry every single file if it fails.
    // TODO: update compiler functionality to have a sensible 1 file implementation

}

func startBatchTranspilation(_ config: TranspilerConfig) async throws {
    let logger = Logger(label: "com.struewer.llvm.transpiler")
    // call QT
    let transpiler = GeneralTranspiler()
    let transpileResult = try await transpiler.transpile(config: config)

    logger.info("\(transpileResult)")
}

func startCompiler(config: CompilerConfig) async throws -> [CompileResult] {
    let logger = Logger(label: "com.struewer.llvm.statistics")
    // get all file paths for compilation (starting from provided base path)
    logger.info("Run LLVM Statistics Comparison for path \(config.inputPath)")
    logger.info("Config loaded \(config)")
    logger.debug("Maximum number of parallel tasks: \(Worker.maximumNumberOfTasks)")

    let compiler = GeneralCompiler(config: config)
    // fill worklist
    let programs = BaseProgram.getProgramsFrom(config.inputPath, languageExtensions: [config.languageExtension])
    logger.info("Found \(programs.count).")
    let workList = ProgramWorkList(items: programs)
    // work worklist
    let compileResults = await withTaskGroup(
        of: [CompileResult].self,
        returning: [CompileResult].self
    ) { taskGroup in

        var groupResult: [CompileResult] = []

        for i in 0..<Worker.maximumNumberOfTasks {
            taskGroup.addTask {
                let worker = Worker(workerNumber: i, compiler: compiler)
                var results: [CompileResult] = []
                while let item = await workList.next() {
                    logger.info(
                        "Starting work on: \(item.name) with worker no \(i)"
                    )
                    do {
                        let result = try await worker.work(item)
                        results.append(result)
                        if let stdOut = result.stdOut {
                            try FileHelperFactory.getFileHelper().storeJson(
                                dirPath: config.outputPath, fileName: "\(item.name)-output.txt", element: stdOut)
                        }
                        logger.info(
                            "Finished work on: \(item.name) with worker no \(i)"
                        )
                    } catch {
                        logger.error("Worker failed for item \(item) failed with error \(error).")

                    }
                }
                return results
            }
        }

        for await childRes in taskGroup {
            groupResult.append(contentsOf: childRes)
        }
        return groupResult
    }

    //TODO: get additional data for result - go from program path and collect request/response data
    // go from base path and get config data
    var csvFile: CsvFile

    let inputOutputLanguages =
        FileHelperFactory.getFileHelper().getFileContents(path: config.inputPath, elementSuffix: "config.json")
        as [InputOutputLanguage]
    if inputOutputLanguages.count == 1 && inputOutputLanguages.first != nil {
        let inputOutputLanguage = inputOutputLanguages.first!
        csvFile = CsvFile(
            compileResults: compileResults, sourceLanguage: inputOutputLanguage.sourceLanguage,
            targetLanguage: inputOutputLanguage.targetLanguage)
    } else {
        logger.warning("Found more than one or none config.json file at \(config.inputPath)")
        csvFile = CsvFile(compileResults: compileResults)
    }
    try csvFile.storeData(path: config.outputPath)

    let initialValue: Int32 = 0
    let failedPrograms = compileResults.reduce(
        initialValue,
        {
            acc, res in
            acc + res.returnCode
        })

    logger.info("Task group finished. Of \(programs.count) input programs \(failedPrograms) failed to compile.")
    return compileResults
}
