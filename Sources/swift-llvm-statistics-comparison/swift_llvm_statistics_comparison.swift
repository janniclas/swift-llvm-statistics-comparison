import Foundation
import ArgumentParser


@main
@available(macOS 10.15, *)
struct swift_llvm_statistics_comparison: AsyncParsableCommand {
    
    
    @Option(help: "Directory path to scan for files.")
    var path: String
    
    
}

@available(macOS 10.15, *)
extension swift_llvm_statistics_comparison {
    mutating func run() async throws {
        
        
        print("path found \(path)")
        let diffCalc = DiffCalculator(basePath: path)
        try diffCalc.run()
        
    }
}
