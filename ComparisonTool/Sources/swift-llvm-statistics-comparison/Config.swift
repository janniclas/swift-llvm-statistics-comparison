//
//  Config.swift
//
//
//  Created by Jan-Niclas Strüwer on 07.01.23.
//

import Foundation

func loadConfig(path: String) throws -> Config {
    let fh = FileHelperFactory.getFileHelper()

    return try fh.readContent(path: path) as Config
}

struct Config: Codable {

    let compilerPath: String
    let compilerSettings: [String]
    // TODO: do we need a compiler output extension or naming pattern here? probably yes because we generate files with different extensions
    let compilerOutFlag: String
    let compilerOutExtension: String

    let outputPath: String
    let inputPath: String
}
