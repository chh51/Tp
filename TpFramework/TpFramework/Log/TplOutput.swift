import Foundation

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
