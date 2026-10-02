import Foundation
import os.log

enum LogCategory: String {
    case network = "Network"
    case database = "Database"
    case authentication = "Authentication"
    case orders = "Orders"
    case ui = "UI"
    case analytics = "Analytics"
}

struct AppLogger {
    static func log(_ message: String, category: LogCategory, type: OSLogType = .default) {
        let osLog = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.biteflow.app", category: category.rawValue)
        os_log("%{public}@", log: osLog, type: type, message)
    }
    
    static func error(_ message: String, category: LogCategory) {
        log(message, category: category, type: .error)
    }
    
    static func debug(_ message: String, category: LogCategory) {
        #if DEBUG
        log(message, category: category, type: .debug)
        #endif
    }
}
