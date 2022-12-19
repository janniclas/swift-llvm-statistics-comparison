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

    let language: PL

    let name: String
    let path: String

    var irPath: String?
    var statistics: Statistics?
}

@available(macOS 12.0, *)
actor FileWorklist {

    /// Program name -> Programs
    let programs: [String: (_: Program, _: Program?)]
    fileprivate var idx: Dictionary<String, (_: Program, _: Program?)>.Index

    var isEmpty: Bool

    init() {
        self.init(programs: [:])
    }

    init(programs: [String: (_: Program, _: Program?)]) {
        self.programs = programs
        self.idx = self.programs.startIndex
        self.isEmpty = programs.isEmpty
    }

    func next() -> (_: Program, _: Program?)? {
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
@available(macOS 13.0, *)
struct Worker {

    init(workerNumber: UInt8) {
        self.workerNumber = workerNumber
        print("Initialized worker \(workerNumber)")
    }
    static let maximumNumberOfTasks: UInt8 = 8
    let workerNumber: UInt8
    func work(_: (_: Program, _: Program?)) async {
        print("worker no \(workerNumber) working")

        let rand = Int.random(in: 1...20)
        do { try await Task.sleep(until: .now + .seconds(rand), clock: .continuous) } catch {}

    }
}

func getPrograms(_ basePath: String) -> [String: (_: Program, _: Program?)] {

    var programs: [String: (_: Program, _: Program?)] = [:]
    let fh = FileHelperFactory.getFileHelper()
    let paths = fh.getFilePaths(path: basePath, elementSuffixes: [".swift", ".cpp"])
    for p in paths {
        print("key: \(p.key) path: \(p.value)")
        let pl = p.key == ".swift" ? Program.PL.swift : Program.PL.cpp

        for e in p.value {
            let sProgram = getProgramFromPath(e, type: pl)
            print(sProgram)
            if var pe = programs[sProgram.name] {
                pe.1 = sProgram
                programs.updateValue(pe, forKey: sProgram.name)
            } else {
                programs[sProgram.name] = (sProgram, nil)
            }

        }

    }

    return programs
}

func getProgramFromPath(_ path: String, type: Program.PL) -> Program {
    let fh = FileHelperFactory.getFileHelper()
    var fileName: String
    do {
        fileName = try fh.getFileName(path: path)
    } catch {
        fileName = "invalidName_\(path)"
    }

    return Program(language: type, name: fileName, path: path)
}

@available(macOS 13.0, *)
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
                        "Starting work on: \(item.0.name) and: \(item.1?.name ?? "") with worker no \(i)"
                    )
                    await worker.work(item)
                    print(
                        "Finished work on swift: \(item.0.name) and cpp: \(item.1?.name ?? "") with worker no \(i)"
                    )
                }
            }
        }
    }
    print("Task group finished")
}
