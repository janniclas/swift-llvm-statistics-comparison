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
        //TODO: add config input for compiler settings
        //TODO: add execution mode (compare/create ir, compilation only)
        @Option(help: "Directory path to scan for files.")
        var path: String

        @Argument(help: "Which mode to run. Curent valid modes diff and compile.")
        var mode: Mode
    }

    @available(macOS 13.0, *)
    extension swift_llvm_statistics_comparison {

        mutating func run() async throws {
            LoggingSystem.bootstrap(UnifiedLogger.init)
            switch mode {
            case .diff:
                try await startDiff(path: path)
            case .compile:
                try await start(path: path)
            }

        }
    }
#endif
#if os(Linux)
    @main
    struct swift_llvm_statistics_comparison {
        static func main() throws {
            let path = getPath(args: CommandLine.arguments)
            if path != "" {
                try start(path: path)
            } else {
                print("Path Argument not found.")
            }
        }
    }

    func getPath(args: [String]) -> String {
        var p = ""
        for index in 1..<args.count {
            logger.info(index)
            let argument = args[index]
            if argument == "--path" {
                if index + 1 < args.count {
                    p = args[index + 1]
                    break
                }
            }
        }
        return p
    }
#endif
func startDiff(path: String) async throws {
    let logger = Logger(label: "com.struewer.llvm.statistics")
    let diffCalc = DiffCalculator(basePath: path)
    try diffCalc.run()
}

func start(path: String) async throws {
    let logger = Logger(label: "com.struewer.llvm.statistics")
    // get all file paths for compilation (starting from provided base path)
    logger.info("Run LLVM Statistics Comparison for path \(path)")
    logger.debug("Maximum number of parallel tasks: \(Worker.maximumNumberOfTasks)")
    // fill worklist
    let programs = Program.getProgramsFrom(path)
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
                let worker = Worker(workerNumber: i)
                var results: [CompileResult] = []
                while let item = await workList.next() {
                    logger.info(
                        "Starting work on: \(item.name) with worker no \(i)"
                    )
                    do {
                        let result = try await worker.work(item)
                        results.append(result)
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

    logger.info("Task group finished. Of \(programs.count) input programs \(failedPrograms) failed to compile.")
}
