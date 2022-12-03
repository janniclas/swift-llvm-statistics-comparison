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
        static func main() {
            print("We don't support linux right now but this might change soon.")
        }
    }
#endif

func start(path: String) throws {
    print("path found \(path)")
    let diffCalc = DiffCalculator(basePath: path)
    try diffCalc.run()
}
