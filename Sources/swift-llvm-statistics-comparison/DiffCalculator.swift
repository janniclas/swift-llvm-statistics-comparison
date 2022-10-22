//
//  DiffCalculator.swift
//  
//
//  Created by Jan-Niclas Strüwer on 22.10.22.
//

import Foundation


struct DiffCalculator {
    let basePath: String
    
    func run() throws {
        print("Search statistics at path: \(self.basePath)")
        let statistics = getFileContents(path: self.basePath, elementSuffix: "psr-IrStatistics.json") as [PhasarStatistics]
        print("successfully retrieved \(statistics.count) statistics.")
        
        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        let diffs: [String: Diff] = calculateAllDiffs(statistics: statistics)
        
        let onlyCompleteDiffs = diffs.filter({$0.value.diff != nil})
        let sortedDiffs = onlyCompleteDiffs.sorted(by: { $0.value.diff! < $1.value.diff! })
        
        try storeDiffs(diffs: sortedDiffs)
    }
    
    private func storeDiffs(diffs: [Dictionary<String, Diff>.Element]) throws {
        let outputPath = appendToPath(basePath: self.basePath, components: "diffs")
        
        if(!FileManager.default.fileExists(atPath: outputPath)) {
            try FileManager.default.createDirectory(atPath: outputPath, withIntermediateDirectories: false)
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        for diff in diffs {
            let fileOutput = appendToPath(basePath: outputPath, components: diff.key+"-comparison.json")
            print(fileOutput)
            FileManager.default.createFile(atPath: fileOutput, contents: try encoder.encode(diff.value))
        }
        print("Diffs were saved to \(outputPath)")
    }
    
    
    private func calculateAllDiffs(statistics: [PhasarStatistics] ) -> Dictionary<String, Diff> {
        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        var diffs: [String: Diff] = [:]
        for stat in statistics {
            
            if var normalizedModuleName = try? getNormalized(moduleName: stat.moduleName) {
                
                
                if let fileType: BaseLanguage = try? getBaseLanguage(moduleName: &normalizedModuleName) {
                    
                    if diffs[normalizedModuleName] == nil {
                        diffs[normalizedModuleName] = Diff()
                    }
                    
                    let diff = diffs[normalizedModuleName]!
                    
                    switch fileType {
                    case .swift:
                        if diff.swift == nil {
                            diff.swift = stat
                        } else {
                            print("Duplicate entry found for \(stat.moduleName)")
                        }
                    case .cpp:
                        if diff.cpp == nil {
                            diff.cpp = stat
                        } else {
                            print("Duplicate entry found for \(stat.moduleName)")
                        }
                    }
                    
                    if diff.swift != nil && diff.cpp != nil {
                        diff.diff = calculateDiff(first: diff.swift!, second: diff.cpp!)
                    }
                }
            }
        }
        return diffs
    }
    
    private func calculateDiff(first: PhasarStatistics, second: PhasarStatistics) -> Int {
        // TODO: figure out if this makes sense
        // it could make sense to weigh the different categories
        // also this method produces a positive diff for every single value
        // maybe we should just make the sum positive and let some negative and
        // some positive values weigh each other?
        let insDiff = singleDiff(a: first.instructions, b: second.instructions)
        let allocaDiff = singleDiff(a: first.allocaInstructions, b: second.allocaInstructions)
        let callSiteDiff = singleDiff(a: first.callSites, b: second.callSites)
        let functionsDiff = singleDiff(a: first.functions, b: second.functions)
        let globalDiff = singleDiff(a: first.globalVariables, b: second.globalVariables)
        return insDiff + allocaDiff + callSiteDiff + functionsDiff + globalDiff
    }
    
    private func singleDiff(a: Int, b: Int)-> Int {
        var diff = a - b
        if (diff < 0) {
            diff = diff * -1
        }
        return diff
    }
    
    ///  expected input pattern testName.cpp.ll for C++ and testName.swift.ll for Swift
    ///  expected output testName.cpp or testName.swift
    /// - Parameters:
    ///   - moduleName: The value to be normalized.
    private func getNormalized(moduleName: String) throws -> String {
        
        let result = try getFileName(path: moduleName)
        return result
    }
    
    private func getBaseLanguage( moduleName: inout String) throws -> BaseLanguage {
        if moduleName.contains(".swift") {
            moduleName.removeSubrange(moduleName.firstIndex(of: ".")!..<moduleName.endIndex)
            return BaseLanguage.swift
        } else if moduleName.contains(".cpp") {
            moduleName.removeSubrange(moduleName.firstIndex(of: ".")!..<moduleName.endIndex)
            return BaseLanguage.cpp
        }
        
        throw ModuleNameFormatError.noBaseLanguage(moduleName: moduleName)
    }
    
    
    class Diff: Codable {
        var diff: Int?
        var cpp: PhasarStatistics?, swift: PhasarStatistics?
    }
    
    struct PhasarStatistics: Codable {
        let allocaInstructions, callSites, functions, globalVariables: Int
        let instructions: Int
        let moduleName: String
        
        enum CodingKeys: String, CodingKey {
            case allocaInstructions = "AllocaInstructions"
            case callSites = "CallSites"
            case functions = "Functions"
            case globalVariables = "GlobalVariables"
            case instructions = "Instructions"
            case moduleName = "ModuleName"
        }
    }
    
    enum BaseLanguage {
        case swift
        case cpp
    }
    
    enum ModuleNameFormatError: Error {
        case noBaseLanguage(moduleName: String)
        case normalizationFailed(moduleName: String)
    }
    
}
