//
//  File.swift
//
//
//  Created by Jan-Niclas Strüwer on 20.12.22.
//

import Foundation
import Logging

struct Statistics {}

actor WorkList<T> {

    let items: [T]
    fileprivate var idx: Array<T>.Index

    var isEmpty: Bool

    init() {
        self.init(items: [])
    }

    init(items: [T]) {
        self.items = items
        self.idx = self.items.startIndex
        self.isEmpty = items.isEmpty
    }

    func next() -> (T)? {
        if isEmpty {
            return nil
        }
        let next = items[idx]
        idx = items.index(after: idx)
        if idx == items.endIndex {
            isEmpty = true
        }
        return next
    }
}

typealias ProgramWorkList = WorkList<Program>
typealias ProgramTupleWorkList = WorkList<(_: Program, _: Program?)>

struct Worker {

    init(workerNumber: UInt, compiler: Compiler) {
        self.workerNumber = workerNumber
        self.compiler = compiler
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
    let compiler: Compiler

    private func processProgram(_ program: Program) async throws -> CompileResult {
        return try await compiler.compile(program)
    }

    func work(_ program: Program) async throws -> CompileResult {
        return try await processProgram(program)
    }

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
