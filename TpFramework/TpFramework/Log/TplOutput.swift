import Foundation
import Atomics

/// Output stream for *TplEntry*
public enum eTplOutput: Int, CaseIterable, Identifiable, pTpcArrayable {
    
    /// Debug console
    case eConsole           = 0
    /// Persist local memory
    case ePersistMemory     = 1
    /// Persist local file
    case ePersistFile       = 2
    /// Persist remote
    case ePersistRemote     = 3
    
    /// Unique descriptive string
    public var description: String {
        switch self {
        case .eConsole:         return "Console"
        case .ePersistMemory:   return "Persist to Memory"
        case .ePersistFile:     return "Persist to File"
        case .ePersistRemote:   return "Persist to Remote"
        }
    }
    
    /// Implement protocol *Identifiable*
    public var id: Int { return self.rawValue }
    
    /// Enumeration as a 0-based index for an array
    public var arrayIndex: Int {
        return self.rawValue
    }
    
    /// Count for 0-based array
    static public func arraySize() -> Int {
        var max_ = -1
        for entry_ in self.allCases {
            max_ = max( max_, entry_.arrayIndex )
        }
        return max_ + 1
    }
}

/// Output stream status
public enum eTplOutputStatus: Int, CaseIterable, Identifiable, pTpcArrayable, AtomicValue {
    
    /// Not implemented
    case eNotImplemented    = 0
    /// Disabled
    case eDisabled          = 1
    /// Inactive ( can be switched to *eActive* )
    case eInactive          = 2
    /// Active ( can be switched to *eInactive* )
    case eActive            = 3
    
    /// Unique descriptive string
    public var description: String {
        switch self {
        case .eNotImplemented:         return "Not Implemented"
        case .eDisabled:               return "Disabled"
        case .eInactive:               return "Inactive"
        case .eActive:                 return "Active"
        }
    }
    
    /// Implement protocol *Identifiable*
    public var id: Int { return self.rawValue }
    
    /// Enumeration as a 0-based index for an array
    public var arrayIndex: Int {
        return self.rawValue
    }
    
    /// Count for 0-based array
    static public func arraySize() -> Int {
        var max_ = -1
        for entry_ in self.allCases {
            max_ = max( max_, entry_.arrayIndex )
        }
        return max_ + 1
    }
}



