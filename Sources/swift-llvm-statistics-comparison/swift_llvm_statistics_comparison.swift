import Foundation

@main
public struct swift_llvm_statistics_comparison {

    public static func main() {
        let statistics = gatherStatisticsFiles(path: "/Users/struewer/git/swift-analysis-benchmark/src/linearConstantPropagation/swift")
        print(statistics)
        
        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        var diffs: [String: Diff] = [:]
        for stat in statistics {

            if let normalizedModuleName = try? getNormalized(moduleName: stat.moduleName) {
                
                if diffs[normalizedModuleName] == nil {
                    diffs[normalizedModuleName] = Diff()
                }
                
                // TODO: check how and if changes to diff are propagated inside the dictionary
                var diff = diffs[normalizedModuleName]!

                if let fileType: BaseLanguage = try? getBaseLanguage(moduleName: stat.moduleName) {
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
                }
                
                if diff.swift != nil && diff.cpp != nil {
                    diff.diff = calculateDiff(first: diff.swift!, second: diff.cpp!)
                }
            }
        }
        let sortedDiffs = diffs.sorted(by: { $0.value.diff! < $1.value.diff! })
        for sDiff in sortedDiffs {
            print(sDiff)
        }
    }
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

///  expected input pattern testName_cpp.ll for C++ and testName_swift.ll for Swift
///  expected output testName
/// - Parameters:
///   - moduleName: The value to be normalized.
func getNormalized(moduleName: String) throws -> String {
    var res: Substring = Substring(moduleName)
    if let lastSlashIdx = moduleName.lastIndex(of: "/") {
        res = moduleName.suffix(from: lastSlashIdx)
        res.removeFirst()
        print(res)
    }
    if let firstUnderscoreIdx = moduleName.firstIndex(of: "_") {
        res = res.prefix(upTo: firstUnderscoreIdx)
        print(res)
        return String(res)
    }
    throw ModuleNameFormatError.normalizationFailed(moduleName: moduleName)
}

func getBaseLanguage(moduleName: String) throws -> BaseLanguage {
    if moduleName.contains("_swift.ll") {
        return BaseLanguage.swift
    } else if moduleName.contains("_cpp.ll") {
        return BaseLanguage.cpp
    }

    throw ModuleNameFormatError.noBaseLanguage(moduleName: moduleName)
}

func gatherStatisticsFiles(path: String) -> [PhasarStatistics] {
    var statistics: [PhasarStatistics] = []
    let enumerator = FileManager.default.enumerator(atPath: path)
    
       while let element = enumerator?.nextObject() as? String {
           print(element)

           if let fType = enumerator?.fileAttributes?[FileAttributeKey.type] as? FileAttributeType {
               if (fType == .typeRegular && element.hasSuffix("psr-statistics.json")) {
                   print("a file")
                   if let stats = readContent(path: element) {
                       statistics.append(stats)
                   }
               }
           }
       }
    return statistics
}

func readContent(path: String)-> PhasarStatistics? {
    if let content = FileManager.default.contents(atPath: path) {
        if let statistics: PhasarStatistics = try? JSONDecoder().decode(PhasarStatistics.self, from: content) { return statistics}
    }
    print("Expected statistics at path \(path)")
    return nil
}

struct Diff: Codable {
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
