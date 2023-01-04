//
//  File.swift
//
//
//  Created by Jan-Niclas Strüwer on 20.12.22.
//

import Foundation
import Logging

struct Statistics {}

// TODO: abstract this to fit to general programs without ir path. maybe keep some sort of output path to also fit compiled programs. also we want to keep the folder structure of the input programs this could maybe also be included here.
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

//TODO: update this to support single programs not only tuples
// struct FileWorkList<T> where T: Program OR T: (_: Program, _: Program?)
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

struct Worker {

    init(workerNumber: UInt) {
        self.workerNumber = workerNumber
        logger.info("Initialized worker \(workerNumber)")
    }

    internal let logger = Logger(label: "com.struewer.llvm.statistics.worker")
    static let maximumNumberOfTasks: UInt = physicalCoresCount()

    private static func physicalCoresCount() -> UInt {

        var size: size_t = MemoryLayout<UInt>.size
        var coresCount: UInt = 0

        sysctlbyname("hw.perflevel0.physicalcpu", &coresCount, &size, nil, 0)

        return coresCount
    }

    let workerNumber: UInt
    let compiler = CompilerFactory.getCompiler()

    private func processProgram(_ program: Program) async throws -> CompileResult {
        return try await compiler.compileToIR(program)
    }

    func work(_ program: Program) async throws -> CompileResult {
        return try await processProgram(program)
    }

    //TODO: we should probably do error handling here somewhere. those try await things look scary on their own
    func work(_ programs: (_: Program, _: Program?)) async throws -> (_: CompileResult, _: CompileResult?) {
        var res: (_: CompileResult, _: CompileResult?)

        res.0 = try await processProgram(programs.0)

        if let p1 = programs.1 {
            res.1 = try await processProgram(p1)
        } else {
            res.1 = nil
        }

        return res
    }
}
