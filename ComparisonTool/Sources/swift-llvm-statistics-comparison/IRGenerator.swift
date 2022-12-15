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
    enum State {
        case awaitIrGen
        case irGenInProgress
        case awaitAnalysis
        case analysisInProgress
        case awaitComparison
        case comparisonInProgress
        case finished
    }
    let language: PL

    let name: String
    let path: String

    var irPath: String
    var statistics: Statistics

    var state: State

}

actor FileWorklist {
    /// Program name -> Programs
    var programs: [String: (swift: Program?, cpp: Program?)]
    private var idx: Dictionary<String, (swift: Program?, cpp: Program?)>.Index

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
        let res = programs[idx]
        idx = programs.index(after: idx)
        return res.value
    }
}

struct Worker {
    static let maximumNumberOfTasks: UInt8 = 8
    static func work(_: (swift: Program?, cpp: Program?)) async {}
}

func generateIr(workList: FileWorklist) async {
    if #available(macOS 10.15, *) {
        await withTaskGroup(of: Void.self) { taskGroup in
            for _ in 0..<Worker.maximumNumberOfTasks {
                taskGroup.addTask {
                    while await !workList.isEmpty {
                        let next = await workList.next()
                        if let item = next {
                            print("Starting work on swift: \(item.swift?.name ?? "") and cpp: \(item.cpp?.name ?? "")")
                            await Worker.work(item)
                            print("Finished work on swift: \(item.swift?.name ?? "") and cpp: \(item.cpp?.name ?? "")")
                        } else {
                            break
                        }
                    }
                }
            }
        }
        //     if #available(macOS 10.15, *) {
        //         await withTaskGroup(of: Void.self) { taskGroup in
        //             var taskCount = 0
        //             while await !workList.isEmpty {
        //
        //                 if taskCount == Worker.maximumNumberOfTasks {
        //                     await taskGroup.next()
        //                     taskCount -= 1
        //                 } else {
        //                     taskCount += 1
        //                     let next = await workList.next()
        //                     if let item = next {
        //                         taskGroup.addTask {
        //                             print("Starting work on swift: \(item.swift?.name ?? "") and cpp: \(item.cpp?.name ?? "")")
        //                              await Worker.work(item)
        //                             print("Finished work on swift: \(item.swift?.name ?? "") and cpp: \(item.cpp?.name ?? "")")
        //                         }
        //                     } else {
        //                         break
        //                     }
        //                 }
        //             }
        //         }
    } else {
        // Fallback on earlier versions
    }
}
