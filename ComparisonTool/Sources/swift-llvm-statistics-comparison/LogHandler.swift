//
//  LogHandler.swift
//
//
//  Created by Jan-Niclas Strüwer on 03.01.23.
//
#if canImport(Darwin)
    @preconcurrency import os
    import Foundation
    import Logging
    import OSLog

    @available(OSX 11.0, *)
    struct UnifiedLogger: LogHandler {

        private let logger: os.Logger

        public init(label: String) {

            let bundleIdent = Bundle.main.bundleIdentifier ?? "swift-llvm-statistics-comparison-log"
            self.logger = Logger(subsystem: bundleIdent, category: label)
        }

        subscript(metadataKey metadataKey: String) -> Logging.Logger.Metadata.Value? {
            get {
                self.metadata[metadataKey]
            }
            set(newValue) {
                self.metadata[metadataKey] = newValue
            }
        }

        var metadata: Logging.Logger.Metadata = [:]

        var logLevel: Logging.Logger.Level = .info

        func log(
            level: Logging.Logger.Level,
            message: Logging.Logger.Message,
            metadata: Logging.Logger.Metadata?,
            source: String,
            file: String,
            function: String,
            line: UInt
        ) {
            self.logger.log(level: logType(level), "\(message.description)")
        }

        private func logType(_ level: Logging.Logger.Level) -> OSLogType {
            switch level {
            case .trace:
                // `OSLog` doesn't have `trace`, so use `debug` instead.
                return .debug
            case .debug:
                return .debug
            case .info:
                return .info
            case .notice:
                // `OSLog` doesn't have `notice`, so use `info` instead.
                return .info
            case .warning:
                // `OSLog` doesn't have `warning`, so use `default` instead.
                return .default
            case .error:
                return .error
            case .critical:
                // `OSLog` doesn't have `critical`, so use `.fault` instead.
                return .fault
            }
        }
    }
#endif  // canImport(Darwin)
