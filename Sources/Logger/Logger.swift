
import Foundation
import os

public struct Logger {
    private let onlyLogInDebugMode: Bool
    
    public init(onlyLogInDebugMode: Bool) {
        self.onlyLogInDebugMode = onlyLogInDebugMode
    }
    
    private let osLogger: os.Logger = .init()
    
    private var shouldLog: Bool {
        #if DEBUG
            return true
        #else
            return onlyLogInDebugMode
        #endif
    }
}

extension Logger {
    public func log(type: LogType, message: String) {
        guard shouldLog else {
            return
        }
        
        switch type {
        case .error:
            osLogger.critical("\("🆘 " + message)")
        case .info:
            osLogger.info("\("ℹ️ " + message)")
        case .warning:
            osLogger.warning("\("⚠️ " + message)")
        case .action:
            osLogger.notice("\("🔵 " + message)")
        case .success:
            osLogger.notice("\("✅ " + message)")
        case .withoutIcon:
            osLogger.info("\(message)")
        }
    }
}
