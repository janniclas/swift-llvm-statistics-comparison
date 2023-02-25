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
        @Argument(help: "Which mode to run. Curent valid modes diff, transpile, and compile.")
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
                //TODO: calculate average values for stuff like loc and global variables acrosse all Swift and C++ files
                let diffAndCompileConfig = try loadConfig(path: config) as DiffConfig
                try await startDiff(config: diffAndCompileConfig)
            case .compile:
                let diffAndCompileConfig = try loadConfig(path: config) as CompilerConfig
                let _ = try await startCompiler(config: diffAndCompileConfig)
            case .transpile:
                let transConfig = try loadConfig(path: config) as TranspileModeConfig
                try await transpile(config: transConfig)
            }

        }
    }
#endif
#if os(Linux)

    enum Mode: String {
        case diff = "diff"
        case compile = "compile"
        case transpile = "transpile"
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
                //TODO: calculate average values for stuff like loc and global variables acrosse all Swift and C++ files
                let diffAndCompileConfig = try loadConfig(path: args.path) as DiffConfig
                try await startDiff(config: diffAndCompileConfig)
            case .compile:
                let diffAndCompileConfig = try loadConfig(path: args.path) as CompilerConfig
                let _ = try await startCompiler(config: diffAndCompileConfig)
            case .transpile:
                let transConfig = try loadConfig(path: args.path) as TranspileModeConfig
                try await transpile(config: transConfig)
            }
        }
    }

    func getPath(args: [String]) throws -> (mode: Mode, path: String) {
        var mode: Mode?
        var p: String?
        for index in 1..<args.count {
            let argument: String = args[index]
            switch argument {
            case "diff":
                mode = .diff
            case "compile":
                mode = .compile
            case "transpile":
                mode = .transpile
            case "--config":
                if index + 1 < args.count {
                    p = args[index + 1]
                }
                break
            default:
                print("Ignoring argument \(argument)")
            }
        }
        if mode != nil && p != nil {
            return (mode!, p!)
        }
        throw ArgError.unkownArgument(arg: "Mode or path not initialized")
    }
#endif

func startDiff(config: DiffConfig) async throws {
    let logger = Logger(label: "com.struewer.llvm.statistics")

    let firstLanguageCompileResult = try await startCompiler(
        config: config.firstLanguage, logging: false
    )
    .filter { r in r.returnCode == 0 }
    .map { r in r.program }

    let secondLanguageCompileResult = try await startCompiler(
        config: config.secondLanguage, logging: false
    )
    .filter { r in r.returnCode == 0 }
    .map { r in r.program }

    let programs = firstLanguageCompileResult + secondLanguageCompileResult

    let _ = try await runDocker(config: config.dockerConfig, programs: programs)

    let diffCalculator = DiffCalculator(basePath: config.outputBasePath)
    try diffCalculator.run()
}

func runDocker(config: DockerConfig, programs: [ProgramWithCompileOutput]) async throws {
    let logger = Logger(label: "com.struewer.llvm.dockerrunner")
    let docker = DockerRunner()
    logger.info("Starting docker for programs \(programs)")
    let fh = FileHelperFactory.getFileHelper()
    for program in programs {
        if let inputPath = fh.getDirectoryPathForFile(filePath: program.outputPath) {
            if let programPath = try? fh.getFileNameWithExtension(path: program.outputPath) {
                let dockerRunnerConfig = DockerRunnerConfig(
                    config: config, programName: programPath, inputPath: inputPath)
                let _ = try await docker.run(config: dockerRunnerConfig)
            }
        }
    }
}

func transpile(config: TranspileModeConfig) async throws {
    let logger = Logger(label: "com.struewer.llvm.transpiler")
    let fh = FileHelperFactory.getFileHelper()
    let transpileFilePaths = fh.getFilePaths(path: config.inputPath, elementSuffix: config.sourceLanguageExtension)
    let transpiler = GeneralTranspiler()
    logger.info("Starting transpiler for paths \(transpileFilePaths)")
    var compileResults: [CompileResult] = []

    var avgTriesCounter = 0
    var sucessfulAfterRetry = 0
    for path in transpileFilePaths {
        logger.debug("Transpiling for path \(path)")
        var i = 0
        repeat {
            logger.debug("Try \(i)")
            let outPath = fh.appendToPath(basePath: config.outputPath, components: "try-\(i)")
            let transpilerConfig = TranspilerConfig(config, inputPath: path, outputPath: outPath, singleFileMode: true)
            let transpilerResult = try await transpiler.transpile(config: transpilerConfig)
            logger.debug("Transpiler finished with result \(transpilerResult)")
            let transpileResultPath = try fh.appendToPath(
                basePath: outPath, components: "\(fh.getFileName(path: path))\(config.targetLanguageExtension)")
            logger.debug("Transpiler Result path \(transpileResultPath)")
            let compilerConfig = CompilerConfig(
                compilerPath: config.compilerPath, compilerSettings: config.compilerSettings,
                languageExtension: config.targetLanguageExtension, compilerOutFlag: config.compilerOutFlag,
                compilerOutExtension: config.compilerOutExtension, outputPath: outPath, inputPath: transpileResultPath)
            let compiler = GeneralCompiler(config: compilerConfig)
            let program = BaseProgram.getProgramFromPath(
                transpileResultPath, languageExtension: config.targetLanguageExtension)
            logger.debug("Compiler Program \(program)")
            let compileResult = try await compiler.compile(program)
            compileResults.append(compileResult)
            logger.debug("Compile Result \(compileResult)")
            if compileResult.returnCode == 0 {
                // this breaks the loop
                if i > 0 {
                    sucessfulAfterRetry = sucessfulAfterRetry + 1
                }
                logger.info("Transpilation successfull after \(i + 1) tries.")
                avgTriesCounter = avgTriesCounter + i + 1
                i = 3
            } else {
                i = i + 1
            }
        } while i < 3
    }

    let avgTries: Double = Double(avgTriesCounter) / Double(transpileFilePaths.count)
    logger.info("Avg used tries \(avgTries)")
    logger.info("Successfull after retries \(sucessfulAfterRetry)")
    //TODO: create the csv log
    let csvFile = CsvFile(
        compileResults: compileResults, sourceLanguage: config.sourceLanguage,
        targetLanguage: config.targetLanguage)

    try csvFile.storeData(path: config.outputPath)
}

func startCompiler(config: CompilerConfig, logging: Bool = true) async throws -> [CompileResult] {
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
                        "Starting work on: \(item) with worker no \(i)"
                    )
                    do {
                        let result = try await worker.work(item)
                        logger.info("Work finished for item \(item)")
                        results.append(result)
                        if let stdOut = result.stdOut {
                            if stdOut != "No output generated" {
                                try FileHelperFactory.getFileHelper().storeJson(
                                    dirPath: config.outputPath, fileName: "\(item.name)-output.txt", element: stdOut)
                                logger.info("Output saved for \(item.name) with worker no \(i)")
                            }
                        }
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
    if logging {
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
    }
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
