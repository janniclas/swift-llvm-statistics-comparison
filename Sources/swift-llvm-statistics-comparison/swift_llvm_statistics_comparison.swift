import Foundation
import ArgumentParser
import System




@main
struct swift_llvm_statistics_comparison: ParsableCommand {

    
    @Option(help: "Directory path to scan for statistics files.")
    var path: String
    
    mutating func run() throws {
        if #available(macOS 12.0, *) {
            let filePath = FilePath(path)
            print("Search statistics at path: \(path)")
            let statistics = gatherStatisticsFiles(path: filePath)
            print("successfully retrieved \(statistics.count) statistics.")
            
            // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
            let diffs: [String: Diff] = calculateAllDiffs(statistics: statistics)
            
            let onlyCompleteDiffs = diffs.filter({$0.value.diff != nil})
            let sortedDiffs = onlyCompleteDiffs.sorted(by: { $0.value.diff! < $1.value.diff! })
            
            try storeDiffs(diffs: sortedDiffs, basePath: filePath)
            
        } else {
            print("The required macOS version is to low. We require version 12.0 or newer.")
        }
    }
}

@available(macOS 12.0, *)
func storeDiffs(diffs: [Dictionary<String, Diff>.Element], basePath: FilePath) throws{
    var outputPath = basePath
    outputPath.append("diffs")
    
    if(!FileManager.default.fileExists(atPath: outputPath.string)) {
        try FileManager.default.createDirectory(atPath: outputPath.string, withIntermediateDirectories: false)
    }
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    for diff in diffs {
        var fileOutput = outputPath
        fileOutput.append(diff.key+"-comparison.json")
        print(outputPath.string)
        FileManager.default.createFile(atPath: fileOutput.string, contents: try encoder.encode(diff.value))
    }
    print("Diffs were saved to \(outputPath.string)")
}

@available(macOS 12.0, *)
func calculateAllDiffs(statistics: [PhasarStatistics] ) -> Dictionary<String, Diff> {
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

func calculateDiff(first: PhasarStatistics, second: PhasarStatistics) -> Int {
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

func singleDiff(a: Int, b: Int)-> Int {
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
@available(macOS 12.0, *)
func getNormalized(moduleName: String) throws -> String {

    if let fileName = FilePath(moduleName).lastComponent {
        return fileName.stem
    }
    
    throw ModuleNameFormatError.normalizationFailed(moduleName: moduleName)
}

func getBaseLanguage( moduleName: inout String) throws -> BaseLanguage {
    if moduleName.contains(".swift") {
        moduleName.removeSubrange(moduleName.firstIndex(of: ".")!..<moduleName.endIndex)
        return BaseLanguage.swift
    } else if moduleName.contains(".cpp") {
        moduleName.removeSubrange(moduleName.firstIndex(of: ".")!..<moduleName.endIndex)
        return BaseLanguage.cpp
    }

    throw ModuleNameFormatError.noBaseLanguage(moduleName: moduleName)
}

@available(macOS 12.0, *)
func gatherStatisticsFiles(path: FilePath) -> [PhasarStatistics] {
    var statistics: [PhasarStatistics] = []
    let enumerator = FileManager.default.enumerator(atPath: path.string)

       while let element = enumerator?.nextObject() as? String {

           if let fType = enumerator?.fileAttributes?[FileAttributeKey.type] as? FileAttributeType {
               // we need to check the suffix, because element is the complete path to the file
               // thus the suffix is the filename
               if (fType == .typeRegular && element.hasSuffix("psr-IrStatistics.json")) {
                   var cPath = path
                   cPath.append(element)
                   if let stats = readContent(path: cPath) {
                       statistics.append(stats)
                   }
               }
           }
       }
    return statistics
}

@available(macOS 12.0, *)
func readContent(path: FilePath)-> PhasarStatistics? {

    if let content = FileManager.default.contents(atPath: path.string) {
        if let statistics: PhasarStatistics = try? JSONDecoder().decode(PhasarStatistics.self, from: content) { return statistics}
    }
    print("Expected statistics at path \(path) was not found.")
    return nil
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
