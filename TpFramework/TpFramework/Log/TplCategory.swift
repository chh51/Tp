import Foundation
import Atomics

/// Category of *aTplEntry*
public enum eTplCategory: Int, CaseIterable, Identifiable, pTpcArrayable, AtomicValue {
    /// Test
    case eTest  = 0
    /// Persistent store operations
    case eModel = 1
    /// User interface operations
    case eUI    = 2
    /// Core
    case eCore  = 3
    
    /// Unique descriptive string
    public var description: String {
        switch self {
        case .eModel:           return "Model"
        case .eUI:              return "User Interface"
        case .eCore:            return "Core"
        case .eTest:            return "Test"
        }
    }
    
    /// Unicode.scalar for visual symbol
    public var visualSymbol: Unicode.Scalar {
        switch self {
        case .eCore:    return Unicode.Scalar("c")
        case .eModel:   return Unicode.Scalar("m")
        case .eUI:      return Unicode.Scalar("u")
        case .eTest:    return Unicode.Scalar("t")
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
    /// Implement *Comparable*
    public static func < ( lhs: eTplCategory, rhs: eTplCategory ) -> Bool {
        return lhs.arrayIndex < rhs.arrayIndex
    }
}
