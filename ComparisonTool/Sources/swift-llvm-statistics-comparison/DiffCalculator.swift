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
        //        let statistics =
        //            fileHelper.getFileContents(path: self.basePath, elementSuffix: "psr-IrStatistics.json")
        //            as [PhasarStatistics]

        let statisticPaths = fileHelper.getFilePaths(path: self.basePath, elementSuffix: "psr-IrStatistics.json")
        logger.info("successfully retrieved \(statisticPaths.count) statistic paths.")

        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        let diffs: [String: Diff] = calculateAllDiffs(statisticPaths: statisticPaths)
        let onlyCompleteDiffs = diffs.filter({ $0.value.diff != nil })
        let sortedDiffs = onlyCompleteDiffs.sorted(by: { $0.value.diff! < $1.value.diff! })

        let avgDiffs: [String: AvgDiff] = getAvgDiffs(sortedDiffs.map { sd in sd.value })
        try storeDiffs(diffs: sortedDiffs)
        try storeAvgDiff(diffs: avgDiffs)
    }

    private func getAvgDiffs(_ diffs: [Diff]) -> [String: AvgDiff] {
        var diffSum: [String: (AvgDiff, Int)] = [:]
        diffSum["avg"] = (AvgDiff(), 0)

        for diff in diffs {
            if let outPath = diff.outputPath {
                if diffSum[outPath] == nil {
                    diffSum[outPath] = (AvgDiff(), 0)
                }
                let currentAvg = diffSum[outPath]!

                currentAvg.0.diff += diff.diff ?? 0

                currentAvg.0.swift.allocaInstructions += diff.swift?.allocaInstructions ?? 0
                currentAvg.0.swift.basicBlocks += diff.swift?.basicBlocks ?? 0
                currentAvg.0.swift.branches += diff.swift?.branches ?? 0
                currentAvg.0.swift.callSites += diff.swift?.callSites ?? 0
                currentAvg.0.swift.functions += diff.swift?.functions ?? 0
                currentAvg.0.swift.getElementPtrs += diff.swift?.getElementPtrs ?? 0
                currentAvg.0.swift.globalVariables += diff.swift?.globalVariables ?? 0
                currentAvg.0.swift.instructions += diff.swift?.instructions ?? 0
                currentAvg.0.swift.phiNodes += diff.swift?.phiNodes ?? 0

                currentAvg.0.cpp.allocaInstructions += diff.cpp?.allocaInstructions ?? 0
                currentAvg.0.cpp.basicBlocks += diff.cpp?.basicBlocks ?? 0
                currentAvg.0.cpp.branches += diff.cpp?.branches ?? 0
                currentAvg.0.cpp.callSites += diff.cpp?.callSites ?? 0
                currentAvg.0.cpp.functions += diff.cpp?.functions ?? 0
                currentAvg.0.cpp.getElementPtrs += diff.cpp?.getElementPtrs ?? 0
                currentAvg.0.cpp.globalVariables += diff.cpp?.globalVariables ?? 0
                currentAvg.0.cpp.instructions += diff.cpp?.instructions ?? 0
                currentAvg.0.cpp.phiNodes += diff.cpp?.phiNodes ?? 0

                let avg = diffSum["avg"]!
                avg.0.diff += currentAvg.0.diff
                avg.0.swift.allocaInstructions += currentAvg.0.swift.allocaInstructions
                avg.0.swift.basicBlocks += currentAvg.0.swift.basicBlocks
                avg.0.swift.branches += currentAvg.0.swift.branches
                avg.0.swift.callSites += currentAvg.0.swift.callSites
                avg.0.swift.functions += currentAvg.0.swift.functions
                avg.0.swift.getElementPtrs += currentAvg.0.swift.getElementPtrs
                avg.0.swift.globalVariables += currentAvg.0.swift.globalVariables
                avg.0.swift.instructions += currentAvg.0.swift.instructions
                avg.0.swift.phiNodes += currentAvg.0.swift.phiNodes

                avg.0.cpp.allocaInstructions += currentAvg.0.cpp.allocaInstructions
                avg.0.cpp.basicBlocks += currentAvg.0.cpp.basicBlocks
                avg.0.cpp.branches += currentAvg.0.cpp.branches
                avg.0.cpp.callSites += currentAvg.0.cpp.callSites
                avg.0.cpp.functions += currentAvg.0.cpp.functions
                avg.0.cpp.getElementPtrs += currentAvg.0.cpp.getElementPtrs
                avg.0.cpp.globalVariables += currentAvg.0.cpp.globalVariables
                avg.0.cpp.instructions += currentAvg.0.cpp.instructions
                avg.0.cpp.phiNodes += currentAvg.0.cpp.phiNodes
                diffSum["avg"] = (avg.0, avg.1 + 1)
                diffSum[outPath] = (currentAvg.0, currentAvg.1 + 1)
            }
        }
        var avgDiffs: [String: AvgDiff] = [:]

        for (idx, diffAndSum) in diffSum {
            let diff = diffAndSum.0
            let avg = AvgDiff()
            avg.diff = diff.diff / diffAndSum.1

            avg.swift.allocaInstructions += diff.swift.allocaInstructions / diffAndSum.1
            avg.swift.basicBlocks += diff.swift.basicBlocks / diffAndSum.1
            avg.swift.branches += diff.swift.branches / diffAndSum.1
            avg.swift.callSites += diff.swift.callSites / diffAndSum.1
            avg.swift.functions += diff.swift.functions / diffAndSum.1
            avg.swift.getElementPtrs += diff.swift.getElementPtrs / diffAndSum.1
            avg.swift.globalVariables += diff.swift.globalVariables / diffAndSum.1
            avg.swift.instructions += diff.swift.instructions / diffAndSum.1
            avg.swift.phiNodes += diff.swift.phiNodes / diffAndSum.1

            avg.cpp.allocaInstructions += diff.cpp.allocaInstructions / diffAndSum.1
            avg.cpp.basicBlocks += diff.cpp.basicBlocks / diffAndSum.1
            avg.cpp.branches += diff.cpp.branches / diffAndSum.1
            avg.cpp.callSites += diff.cpp.callSites / diffAndSum.1
            avg.cpp.functions += diff.cpp.functions / diffAndSum.1
            avg.cpp.getElementPtrs += diff.cpp.getElementPtrs / diffAndSum.1
            avg.cpp.globalVariables += diff.cpp.globalVariables / diffAndSum.1
            avg.cpp.instructions += diff.cpp.instructions / diffAndSum.1
            avg.cpp.phiNodes += diff.cpp.phiNodes / diffAndSum.1

            avgDiffs[idx] = avg
        }

        return avgDiffs
    }

    private func storeAvgDiff(diffs: [String: AvgDiff]) throws {
        for (path, diff) in diffs {
            let outputPath = fileHelper.appendToPath(
                basePath: self.basePath, components: path)
            try fileHelper.storeJson(
                dirPath: outputPath, fileName: "avg-comparison.json", element: diff)
        }
    }

    private func storeDiffs(diffs: [Dictionary<String, Diff>.Element]) throws {

        for (idx, diff) in diffs.enumerated() {
            let outputPath = fileHelper.appendToPath(
                basePath: self.basePath, components: diff.value.outputPath ?? "diffs")
            diff.value.outputPath = nil
            try fileHelper.storeJson(
                dirPath: outputPath, fileName: "\(idx)-\(diff.key)-comparison.json", element: diff.value)
        }

        logger.info("All diffs were saved.")
    }

    private func getOutputPath(_ p: String) -> String {
        var dirPath = self.fileHelper.getDirectoryPathForFile(filePath: p)
        dirPath = dirPath?.replacingOccurrences(of: self.basePath, with: "")
        if let url = URL(string: dirPath ?? "") {
            if url.pathComponents.count > 2 {
                let res = url.pathComponents[0] + url.pathComponents[1]
                return res
            }
        }
        return p
    }

    private func calculateAllDiffs(statisticPaths: [String]) -> [String: Diff] {
        // moduleName -> {diff: int, cpp: PhasarStatistics, swift: PhasarStatistics}
        var diffs: [String: Diff] = [:]

        for statsPath in statisticPaths {
            if let stat = try? fileHelper.readContent(path: statsPath) as PhasarStatistics {

                if var normalizedModuleName = try? getNormalized(moduleName: stat.moduleName) {

                    if let fileType: BaseLanguage = try? getBaseLanguage(moduleName: &normalizedModuleName) {

                        if diffs[normalizedModuleName] == nil {
                            diffs[normalizedModuleName] = Diff()
                            let outputPath = getOutputPath(statsPath)
                            diffs[normalizedModuleName]?.outputPath = outputPath
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
        if moduleName.contains(BaseProgram.SWIFT_MODULE_LANGUAGE_EXTENSION) {
            moduleName.removeSubrange(moduleName.lastIndex(of: "_")!..<moduleName.endIndex)
            return BaseLanguage.swift
        } else if moduleName.contains(BaseProgram.CPP_MODULE_LANGUAGE_EXTENSION) {
            moduleName.removeSubrange(moduleName.lastIndex(of: "_")!..<moduleName.endIndex)
            return BaseLanguage.cpp
        }

        throw ModuleNameFormatError.noBaseLanguage(moduleName: moduleName)
    }

    class Diff: Codable {
        var diff: Int?
        var cpp: PhasarStatistics?, swift: PhasarStatistics?
        var outputPath: String?
    }

    class AvgStats: Codable {
        var allocaInstructions: Int = 0
        var callSites: Int = 0
        var functions: Int = 0
        var globalVariables: Int = 0
        var instructions: Int = 0
        var branches: Int = 0
        var phiNodes: Int = 0
        var basicBlocks: Int = 0
        var getElementPtrs: Int = 0
    }

    class AvgDiff: Codable {
        var swift = AvgStats()
        var cpp = AvgStats()
        var diff = 0
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
