import Foundation
import os

/// Output stream for *TplEntry*
public enum eTplLevel: Int, CaseIterable, Identifiable, Comparable, pTpcArrayable {
    
    /// Debug - lowest level - equivalent to *OSLogType.debug*
    case eDebug             = 0
    /// Info - equivalent to *OSLogType.info*
    case eInfo              = 1
    /// Default - equivalent to *OSLogType.default*
    case eDefault           = 2
    /// Error - equivalent to *OSLogType.error*
    case eError             = 3
    /// Fault - equivalent to *OSLogType.fault*
    case eFault             = 4

    /// Unique descriptive string
    public var description: String {
        switch self {
        case .eDebug:           return "debug"
        case .eInfo:            return "info"
        case .eDefault:         return "default"
        case .eError:           return "error"
        case .eFault:           return "fault"
        }
    }
    
    /// Equivalent OSLogType
    public var osLogType: OSLogType {
        switch self {
        case .eDebug:           return OSLogType.debug
        case .eInfo:            return OSLogType.info
        case .eDefault:         return OSLogType.default
        case .eError:           return OSLogType.error
        case .eFault:           return OSLogType.fault 
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
    
    /// support for *Comparable* protocol
    public static func < (lhs: eTplLevel, rhs: eTplLevel) -> Bool {
        return ( lhs.rawValue < rhs.rawValue )
    }
}
