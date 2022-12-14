//
//  DiffCalculator.swift
//
//
//  Created by Jan-Niclas Strüwer on 22.10.22.
//

import Foundation
import Logging

struct DiffCalculator {
    let basePath: String
    private let fileHelper = FileHelperFactory.getFileHelper()

    private let logger = Logger(label: "com.struewer.llvm.statistics.fileHelper")

    func run() throws {
        logger.info("Search statistics at path: \(self.basePath)")
        let statistics =
            fileHelper.getFileContents(path: self.basePath, elementSuffix: "psr-IrStatistics.json")
            as [PhasarStatistics]

        logger.info("successfully retrieved \(statistics.count) statistics.")

        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        let diffs: [String: Diff] = calculateAllDiffs(statistics: statistics)

        let onlyCompleteDiffs = diffs.filter({ $0.value.diff != nil })
        let sortedDiffs = onlyCompleteDiffs.sorted(by: { $0.value.diff! < $1.value.diff! })

        try storeDiffs(diffs: sortedDiffs)
    }

    private func storeDiffs(diffs: [Dictionary<String, Diff>.Element]) throws {
        let outputPath = fileHelper.appendToPath(basePath: self.basePath, components: "diffs")

        for (idx, diff) in diffs.enumerated() {
            try fileHelper.storeJson(
                dirPath: outputPath, fileName: "\(idx)-\(diff.key)-comparison.json", element: diff.value)
        }

        logger.info("All diffs were saved to \(outputPath)")
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
                            logger.debug("Duplicate entry found for \(stat.moduleName)")
                        }
                    case .cpp:
                        if diff.cpp == nil {
                            diff.cpp = stat
                        } else {
                            logger.debug("Duplicate entry found for \(stat.moduleName)")
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
        let getElementPtrDiff = singleDiff(first.getElementPtrs, second.getElementPtrs)
        let basicBlockDiff = singleDiff(first.basicBlocks, second.basicBlocks)
        let branchesDiff = singleDiff(first.branches, second.branches)
        let phiNodesDiff = singleDiff(first.phiNodes, second.phiNodes)
        return insDiff + allocaDiff + callSiteDiff + functionsDiff + globalDiff + getElementPtrDiff + basicBlockDiff
            + branchesDiff + phiNodesDiff
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

        let result = try fileHelper.getFileName(path: moduleName)
        return result
    }

    private func getBaseLanguage(moduleName: inout String) throws -> BaseLanguage {
        if moduleName.contains(BaseProgram.SWIFT_LANGUAGE_EXTENSION) {
            moduleName.removeSubrange(moduleName.firstIndex(of: ".")!..<moduleName.endIndex)
            return BaseLanguage.swift
        } else if moduleName.contains(BaseProgram.CPP_LANGUAGE_EXTENSION) {
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
        let _allocaInstructions, _callSites, _functions, _globalVariables, _instructions, _branches, _phiNodes,
            _basicBlocks,
            _getElementPtrs: Int?
        let moduleName: String

        var allocaInstructions: Int { return _allocaInstructions ?? 0 }
        var callSites: Int { return _callSites ?? 0 }
        var functions: Int { return _functions ?? 0 }
        var globalVariables: Int { return _globalVariables ?? 0 }
        var instructions: Int { return _instructions ?? 0 }
        var branches: Int { return _branches ?? 0 }
        var phiNodes: Int { return _phiNodes ?? 0 }
        var basicBlocks: Int { return _basicBlocks ?? 0 }
        var getElementPtrs: Int { return _getElementPtrs ?? 0 }

        enum CodingKeys: String, CodingKey {
            case _allocaInstructions = "AllocaInstructions"
            case _callSites = "CallSites"
            case _functions = "Functions"  // together with callsites an indication of how distributed the code is. is function handling expensive?
            case _globalVariables = "GlobalVariables"  // have to be taken into account in every function --> increases analysis state
            case _instructions = "Instructions"  // size of the IR --> more to analyze
            case moduleName = "ModuleName"
            case _branches = "Branches"
            case _phiNodes = "PhiNodes"
            case _basicBlocks = "BasicBlocks"
            case _getElementPtrs = "GetElementPtrs"
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
