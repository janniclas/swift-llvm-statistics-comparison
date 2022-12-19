//
//  IRGenerator.swift
//
//
//  Created by Jan-Niclas Strüwer on 15.12.22.
//

import Foundation
import System

struct Statistics {}

class Program {
    enum PL {
        case swift
        case cpp
    }

    let language: PL

    let name: String
    let path: String

    init(language: PL, name: String, path: String) {
        self.language = language
        self.name = name
        self.path = path
        self.irPath = "\(path).ir.ll"
    }

    var irPath: String
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

    static let maximumNumberOfTasks: UInt8 = 8  //TODO: query number of physical cores - 1 and use this here
    let workerNumber: UInt8
    let compiler = Compiler()

    struct Compiler {
        let cppCompilerPath = FilePath("/usr/bin/clang++")
        let cppArgs = ["-emit-llvm", "-g", "-S", "-fno-discard-value-names", "-std=c++20", "-o"]

        let swiftcPath = FilePath("/usr/bin/swiftc")
        let swiftArgs = [
            "-emit-ir", "-g", "-parse-as-library", "-Onone", "-Xfrontend", "-disable-llvm-optzns", "-Xfrontend",
            "-disable-swift-specific-llvm-optzns", "-module-name", "myModule", "-o",
        ]

        private func getCppArgs(_ program: Program) -> [String] {
            var res = cppArgs
            res.insert(program.path, at: 5)
            res.append(program.irPath)
            return res
        }

        private func getSwiftArgs(_ program: Program) -> [String] {
            var res = swiftArgs
            res.insert(program.path, at: 10)
            res.append(program.irPath)

            return res
        }

        private func getCompileConfig(_ program: Program) -> (filePath: FilePath, args: [String]) {

            if program.language == .cpp {
                return (cppCompilerPath, getCppArgs(program))
            } else {
                return (swiftcPath, getSwiftArgs(program))
            }
        }

        func compileProgram(_ program: Program) async {
            let config = getCompileConfig(program)
            let p = Process()

            p.executableURL = URL(filePath: config.filePath)
            p.arguments = config.args

            p.terminationHandler = { (process) in
                print("\ndidFinish: \(!process.isRunning)")
                print("end")
            }

            do {
                try p.run()
            } catch {
                print("error occured")
            }
            p.waitUntilExit()
        }
    }

    private func processProgram(_ program: Program) async {
        await compiler.compileProgram(program)
    }

    func work(_ programs: (_: Program, _: Program?)) async {
        await processProgram(programs.0)
        if let p1 = programs.1 {
            await processProgram(p1)
        }
    }
}

func getPrograms(_ basePath: String) -> [String: (_: Program, _: Program?)] {

    var programDictionary: [String: (_: Program, _: Program?)] = [:]
    let fh = FileHelperFactory.getFileHelper()
    let pathDictionary = fh.getFilePaths(path: basePath, elementSuffixes: [".swift", ".cpp"])
    for p in pathDictionary {
        print("key: \(p.key) path: \(p.value)")
        let pl = p.key == ".swift" ? Program.PL.swift : Program.PL.cpp

        for path in p.value {
            let program = getProgramFromPath(path, type: pl)
            print(program)
            if var programTuple = programDictionary[program.name] {
                programTuple.1 = program
                programDictionary.updateValue(programTuple, forKey: program.name)
            } else {
                programDictionary[program.name] = (program, nil)
            }

        }

    }

    return programDictionary
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
