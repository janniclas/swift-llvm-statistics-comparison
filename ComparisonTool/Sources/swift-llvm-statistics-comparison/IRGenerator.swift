//
//  IRGenerator.swift
//
//
//  Created by Jan-Niclas Strüwer on 15.12.22.
//

import Foundation

struct Statistics {}

struct Program {
    enum PL {
        case swift
        case cpp
    }
    //    enum State {
    //        case awaitIrGen
    //        case irGenInProgress
    //        case awaitAnalysis
    //        case analysisInProgress
    //        case awaitComparison
    //        case comparisonInProgress
    //        case finished
    //    }
    let language: PL

    let name: String
    let path: String

    var irPath: String
    var statistics: Statistics

    //    var state: State

}

actor FileWorklist {

    /// Program name -> Programs
    let programs: [String: (swift: Program?, cpp: Program?)]
    fileprivate var idx: Dictionary<String, (swift: Program?, cpp: Program?)>.Index

    var isEmpty: Bool

    init() {
        self.init(programs: [:])
    }

    init(programs: [String: (swift: Program, cpp: Program)]) {
        self.programs = programs
        self.idx = self.programs.startIndex
        self.isEmpty = programs.isEmpty
    }

    func next() -> (swift: Program?, cpp: Program?)? {
        if isEmpty {
            return nil
        }
        let res = programs[idx]
        idx = programs.index(after: idx)
        if idx == programs.endIndex {
            isEmpty = true
        }
        return res.value
    }

}

struct Worker {

    init(workerNumber: UInt8) {
        self.workerNumber = workerNumber
        print("Initialized worker \(workerNumber)")
    }
    static let maximumNumberOfTasks: UInt8 = 8
    let workerNumber: UInt8
    func work(_: (swift: Program?, cpp: Program?)) async {
        print("worker no \(workerNumber) working")
        if #available(macOS 13.0, *) {
            do { try await Task.sleep(until: .now + .seconds(5), clock: .continuous) } catch {}
        } else {
            // Fallback on earlier versions
        }

    }
}

func getPrograms(_ basePath: String) -> [String: (swift: Program, cpp: Program)] {
    var programs: [String: (swift: Program, cpp: Program)] = [:]
    for i in 1..<12 {
        programs["testP\(i)"] = (
            swift: Program(
                language: Program.PL.swift, name: "Swift\(i)", path: "/tmp/test", irPath: "/tmp/testir",
                statistics: Statistics()),
            cpp: Program(
                language: Program.PL.cpp, name: "Cpp\(i)", path: "/tmp/testcpp", irPath: "/tmp/testircpp",
                statistics: Statistics())
        )
    }

    return programs
}

@available(macOS 10.15, *)
func generateIr(basePath: String) async {
    // fill worklist
    let programs = getPrograms(basePath)
    let workList = FileWorklist(programs: programs)
    // work worklist
    await withTaskGroup(of: Void.self) { taskGroup in
        for i in 0..<Worker.maximumNumberOfTasks {
            taskGroup.addTask {
                let worker = Worker(workerNumber: i)
                while let item = await workList.next() {
                    print(
                        "Starting work on swift: \(item.swift?.name ?? "") and cpp: \(item.cpp?.name ?? "") with worker no \(i)"
                    )
                    await worker.work(item)
                    print(
                        "Finished work on swift: \(item.swift?.name ?? "") and cpp: \(item.cpp?.name ?? "") with worker no \(i)"
                    )
                }
            }
        }
    }
    print("Task group finished")

}
