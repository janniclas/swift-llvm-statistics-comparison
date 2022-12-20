import ArgumentParser
import Foundation

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
            // get all file paths for compilation (starting from provided base path)
            await generateIr(basePath: path)
            //            let processInfo = ProcessInfo()
            //            print(processInfo.activeProcessorCount)
            // let logicalCoresCount = ProcessInfo.processInfo.processorCount
            //            func physicalCoresCount() -> UInt {
            //
            //                var size: size_t = MemoryLayout<UInt>.size
            //                var coresCount: UInt = 0
            //
            //                sysctlbyname("hw.physicalcpu", &coresCount, &size, nil, 0)
            //
            //                return coresCount
            //            }
            // start compile
            // start analysis
            // await all (theoretically we can just await for a
            // pair to compare, however this level of complexity might not be helpful)
            // do comparison
            //            let handle = Task {
            //                let p = Process()
            //                let fp = FilePath("/bin/ls")
            //                p.executableURL = URL(filePath: fp)
            //                p.arguments = ["-l"]
            //                p.terminationHandler = { (process) in
            //                    print("\ndidFinish: \(!process.isRunning)")
            //                    print("end")
            //
            //                }
            //
            //                do {
            //                    try p.run()
            //                } catch {
            //                    print("error occured")
            //                }
            //                p.waitUntilExit()
            //                return "finished"
            //            }
            //
            //            print("outside")
            //            let res = await handle.value
            //            print(res)
            //            try start(path: path)
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
            print(index)
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

func start(path: String) throws {
    let diffCalc = DiffCalculator(basePath: path)
    try diffCalc.run()
}
