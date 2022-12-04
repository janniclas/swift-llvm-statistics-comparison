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
        let statisticsRaw =
            getFileContents(path: self.basePath, elementSuffix: "psr-IrStatistics.json")
            as [PhasarStatisticsJson]
        let statistics = statisticsRaw.map { (json) -> PhasarStatistics in
            return PhasarStatistics(from: json)
        }
        print("successfully retrieved \(statistics.count) statistics.")

        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        let diffs: [String: Diff] = calculateAllDiffs(statistics: statistics)

        let onlyCompleteDiffs = diffs.filter({ $0.value.diff != nil })
        let sortedDiffs = onlyCompleteDiffs.sorted(by: { $0.value.diff! < $1.value.diff! })

        try storeDiffs(diffs: sortedDiffs)
    }

    private func storeDiffs(diffs: [Dictionary<String, Diff>.Element]) throws {
        let outputPath = appendToPath(basePath: self.basePath, components: "diffs")

        if !FileManager.default.fileExists(atPath: outputPath) {
            try FileManager.default.createDirectory(
                atPath: outputPath, withIntermediateDirectories: false)
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        for diff in diffs {
            let fileOutput = appendToPath(basePath: outputPath, components: diff.key + "-comparison.json")
            print(fileOutput)
            FileManager.default.createFile(atPath: fileOutput, contents: try encoder.encode(diff.value))
        }
        print("Diffs were saved to \(outputPath)")
    }

    private func calculateAllDiffs(statistics: [PhasarStatistics]) -> [String: Diff] {
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
                    if let ds = diff.swift, let dc = diff.cpp {
                        diff.diff = calculateDiff(ds, dc)
                    }
                }
            }
        }
        return diffs
    }

    private func calculateDiff(_ first: PhasarStatistics, _ second: PhasarStatistics) -> Int {
        // TODO: figure out if this makes sense
        // it could make sense to weigh the different categories
        // also this method produces a positive diff for every single value
        // maybe we should just make the sum positive and let some negative and
        // some positive values weigh each other?
        let insDiff = singleDiff(first.instructions, second.instructions)
        let allocaDiff = singleDiff(first.allocaInstructions, second.allocaInstructions)
        let callSiteDiff = singleDiff(first.callSites, second.callSites)
        let functionsDiff = singleDiff(first.functions, second.functions)
        let globalDiff = singleDiff(first.globalVariables, second.globalVariables)
        return insDiff + allocaDiff + callSiteDiff + functionsDiff + globalDiff
    }

    private func singleDiff(_ a: Int, _ b: Int) -> Int {
        var diff = a - b
        if diff < 0 {
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

    private func getBaseLanguage(moduleName: inout String) throws -> BaseLanguage {
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
        let allocaInstructions, callSites, functions, globalVariables, instructions, branches, phiNodes, basicBlocks,
            getElementPtrs: Int
        let moduleName: String
        init(from: PhasarStatisticsJson) {
            self.allocaInstructions = from.allocaInstructions ?? 0
            self.callSites = from.callSites ?? 0
            self.functions = from.functions ?? 0
            self.globalVariables = from.globalVariables ?? 0
            self.instructions = from.instructions ?? 0
            self.branches = from.branches ?? 0
            self.phiNodes = from.phiNodes ?? 0
            self.basicBlocks = from.basicBlocks ?? 0
            self.getElementPtrs = from.getElementPtrs ?? 0
            self.moduleName = from.moduleName
        }

    }

    struct PhasarStatisticsJson: Codable {
        let allocaInstructions, callSites, functions, globalVariables, instructions, branches, phiNodes, basicBlocks,
            getElementPtrs: Int?
        let moduleName: String

        enum CodingKeys: String, CodingKey {
            case allocaInstructions = "AllocaInstructions"
            case callSites = "CallSites"
            case functions = "Functions"  // together with callsites an indication of how distributed the code is. is function handling expensive?
            case globalVariables = "GlobalVariables"  // have to be taken into account in every function --> increases analysis state
            case instructions = "Instructions"  // size of the IR --> more to analyze
            case moduleName = "ModuleName"
            case branches = "Branches"
            case phiNodes = "PhiNodes"
            case basicBlocks = "BasicBlocks"
            case getElementPtrs = "GetElementPtrs"
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
