import ArgumentParser
import Foundation
import Logging

#if os(macOS)
    import System

    enum Mode: String, ExpressibleByArgument {
        case diff, compile
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

            let config = try loadConfig(path: config)

            switch mode {
            case .diff:
                try await startDiff(config: config)
            case .compile:
                try await startCompiler(config: config)
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
        static func main() throws {
            let args = try getPath(args: CommandLine.arguments)
            let config = try loadConfig(path: args.path)

            switch args.mode {
            case .diff:
                try await startDiff(config: config)
            case .compile:
                try await startCompiler(config: config)
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

func startDiff(config: Config) async throws {
    let logger = Logger(label: "com.struewer.llvm.statistics")
    logger.info("Started to run in diff mode. Input path \(config.inputPath)")
    let diffCalc = DiffCalculator(basePath: config.inputPath)
    try diffCalc.run()
}

func startCompiler(config: Config) async throws {
    let logger = Logger(label: "com.struewer.llvm.statistics")
    // get all file paths for compilation (starting from provided base path)
    logger.info("Run LLVM Statistics Comparison for path \(config.inputPath)")
    logger.info("Config loaded \(config)")
    logger.debug("Maximum number of parallel tasks: \(Worker.maximumNumberOfTasks)")

    let compiler = GeneralCompiler(config: config)
    // fill worklist
    let programs = BaseProgram.getProgramsFrom(config.inputPath)
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

    let initialValue: Int32 = 0
    let failedPrograms = compileResults.reduce(
        initialValue,
        {
            acc, res in
            acc + res.returnCode
        })

    //TODO: save the results to the output path
    //TODO: reconstruct the input folder structure by starting from the base path and create every folder inbetween the program path and the base path

    logger.info("Task group finished. Of \(programs.count) input programs \(failedPrograms) failed to compile.")
}
