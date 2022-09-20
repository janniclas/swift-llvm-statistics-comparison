import Foundation

@main
public struct swift_llvm_statistics_comparison {

    public static func main() {
        let statistics = gatherStatisticsFiles(path: "/Users/struewer/git/swift-analysis-benchmark/src/linearConstantPropagation/swift")
        print(statistics)
        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        var diffs: [String: Diff] = [:]
        for stat in statistics {
            // expected module name pattern <testName>_cpp.ll for C++ <testName>_swift.ll
            // TODO: need to normalize module name here
            let normalizedModuleName = stat.moduleName

            if diffs[normalizedModuleName] == nil {
                diffs[normalizedModuleName] = Diff()
            }
            
            // TODO: check how and if changes to diff are propagated inside the dictionary
            var diff = diffs[normalizedModuleName]!
            // TODO: get correct file type
            let fileType: BaseFileType = BaseFileType.swift
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
                // TODO: calculate diff here
                diff.diff = 42
            }
        }
        let sortedDiffs = diffs.sorted(by: { $0.value.diff! < $1.value.diff! })
        for sDiff in sortedDiffs {
            print(sDiff)
        }
    }
}

enum BaseFileType {
    case swift
    case cpp
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
