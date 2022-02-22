import Foundation

/// Common properties for types than can be stored in 0-based array
public protocol pTpcArrayable: Comparable {
    
    /// Unique descriptive string
    var description: String { get }
    
    /// Unicode.scalar for visual symbol
    var visualSymbol: Unicode.Scalar { get }
    
    /// Act as a 0-based index for an array
    var arrayIndex: Int  { get }
    
    /// Count for 0-based array
    static func arraySize() -> Int
}
