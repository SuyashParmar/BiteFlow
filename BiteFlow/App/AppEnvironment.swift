import Foundation

enum AppEnvironment {
    case demo
    case production
    
    static var current: AppEnvironment {
        // Defaulting to demo mode as required by instructions
        // Switch to .production when real backend credentials are provided
        return .demo
    }
    
    var isDemoMode: Bool {
        return self == .demo
    }
}
