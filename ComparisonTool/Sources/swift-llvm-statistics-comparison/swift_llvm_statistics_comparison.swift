import ArgumentParser
import Foundation

#if os(macOS)
    @main
    @available(macOS 10.15, *)
    struct swift_llvm_statistics_comparison: AsyncParsableCommand {
        @Option(help: "Directory path to scan for files.")
        var path: String
    }

    @available(macOS 10.15, *)
    extension swift_llvm_statistics_comparison {
        mutating func run() async throws {
            try start(path: path)
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
