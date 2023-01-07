//
//  File.swift
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

    let outputPath: String
    let inputPath: String
}
