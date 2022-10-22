import Foundation
import ArgumentParser


@main
struct swift_llvm_statistics_comparison: ParsableCommand {
    
    
    @Option(help: "Directory path to scan for files.")
    var path: String
    
    mutating func run() throws {
        let diffCalc = DiffCalculator(basePath: path)
        try diffCalc.run()
    }
}
