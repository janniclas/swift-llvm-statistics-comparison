import ArgumentParser
import Foundation
import Logging

#if os(macOS)
    import System

    @main
    @available(macOS 13.0, *)
    struct swift_llvm_statistics_comparison: AsyncParsableCommand {
        @Option(help: "Directory path to scan for files.")
        var path: String
    }

    @available(macOS 13.0, *)
    extension swift_llvm_statistics_comparison {

        mutating func run() async throws {
            LoggingSystem.bootstrap(UnifiedLogger.init)
            try await start(path: path)
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

func start(path: String) async throws {
    let logger = Logger(label: "com.struewer.llvm.statistics")
    // get all file paths for compilation (starting from provided base path)
    logger.info("Run LLVM Statistics Comparison for path \(path)")
    logger.debug("Maximum number of parallel tasks: \(Worker.maximumNumberOfTasks)")
    // fill worklist
    let programs = getPrograms(path)
    logger.info("Found \(programs.count).")
    let workList = FileWorklist(programs: programs)
    // work worklist
    await withTaskGroup(of: Void.self) { taskGroup in
        for i in 0..<Worker.maximumNumberOfTasks {
            taskGroup.addTask {
                let worker = Worker(workerNumber: i)
                while let item = await workList.next() {
                    logger.info(
                        "Starting work on: \(item.0.name) and: \(item.1?.name ?? "") with worker no \(i)"
                    )
                    do {
                        try await worker.work(item)
                        logger.info(
                            "Finished work on swift: \(item.0.name) and cpp: \(item.1?.name ?? "") with worker no \(i)"
                        )
                    } catch {
                        logger.error("Worker failed for item \(item) failed with error \(error).")
                    }
                }
            }
        }
    }
    logger.info("Task group finished")
}
