//
//  DockerRunner.swift
//
//
//  Created by Jan-Niclas Strüwer on 15.12.22.
//

import Foundation
import Logging
import System

struct DockerRunnerResult {
    let externalProgramResult: ExternalProgramResult
    let outputPath: String
}

struct CombinedDockerResults {
    let DockerRunneresult: DockerRunnerResult
    let compileResult: CompileResult
    let numberOfTries: UInt8
}

struct DockerRunnerConfig {
    let config: DockerConfig
    let programName: String
    let inputPath: String
}

class GeneralDockerRunner: ExternalProgram {

    func run(programPath: String, config: DockerRunnerConfig) async throws -> DockerRunnerResult {
        let args = getCliArguments(config: config)
        let url = URL(fileURLWithPath: config.config.dockerPath)

        let res = try await self.run(executableURL: url, args: args)

        return DockerRunnerResult(externalProgramResult: res, outputPath: config.config.outputPath)
    }

    private func getCliArguments(config: DockerRunnerConfig) -> [String] {

        // docker run --mount type=bind,source=${PWD}/$workingdirectory,target=/usr/data/" ghcr.io/secure-software-engineering/phasar:development -m "/usr/data/$fileName" -S --emit-statistics-as-json --project-id "$fileName-results" --out /usr/data

        var args: [String] = [
            "run", "--mount", "type=bind,source=\(config.inputPath),target=/usr/data/", config.config.phasarImage, "-m",
            "/usr/data/\(config.programName)", "-S", "--emit-statistics-as-json", "--project-id",
            "\(config.programName)-results", "--out", "/usr/data",
        ]

        return args
    }

}
