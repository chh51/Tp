import Foundation
import Atomics

/// Configuration for a *eTplCategory*
///
/// Controls which *eTplOutput* and used for different *eTplLevel*
public class cTplCategoryConfig: Identifiable, Equatable {
    
    private struct stArrayLevels {
        var _levels: [cTplOutputLevel] = []
    }

    /// Source for thread-safe sequential *id*
    private static var _lastId = ManagedAtomic<Int64>(0)
    
    /// Unique Identifiable.id within a process lifespan.
    /// Numbered sequentially from 1
    public nonisolated let id:          Int64 =
                _lastId.wrappingIncrementThenLoad(ordering: .sequentiallyConsistent)

    /// The *eTplCategory*
    public nonisolated let category:    eTplCategory
    
    private var outputLevels: [stArrayLevels] = []
    
    /// Simple initializer using default *cTplOutputLevel*
    /// - Parameter category_: *eTplCategory*
    public init( _      category_:      eTplCategory ) {
        category    = category_
        for output_ in eTplOutput.allCases {
            outputLevels.append( initArrayLevel(output: output_ ) )
        }
    }
    
    /// Get *cTplOutputLevel* based on *eTplOutput* and *eTplLevel*
    /// - Parameters:
    ///   - output_: *eTplOutput*
    ///   - level_: *eTplLevel*
    /// - Returns: The matching *cTplOutputLevel*
    public func outputLevel( _ output_: eTplOutput, _ level_: eTplLevel) -> cTplOutputLevel {
        let arrayLevel_ = outputLevels[ output_.arrayIndex ]
        return arrayLevel_._levels[ level_.arrayIndex ]
    }
    
    /// Test if any *eTplOutput* is *eActive* for caller's *eTplLevel*
    ///  Increment *cTplOutputLevel.count* when *eActive*, even though the actual log processing
    ///  will occur after a delay
    /// - Returns: True if any *eTplOutput* is *eActive*
    internal func isLevelActive( _ level_: eTplLevel ) -> Bool {
        var haveActive_ = false
        for output_ in eTplOutput.allCases {
            let outputLevel_ = self.outputLevel( output_, level_ )
            if ( outputLevel_.status == .eActive ) {
                haveActive_ = true
                outputLevel_.incrementCountActive() 
            }
        }
        return haveActive_
    }
    
    /// Support for protocol *Equatable*
    static public func == (lhs: cTplCategoryConfig, rhs: cTplCategoryConfig) -> Bool {
        return lhs.id == rhs.id
    }

    private func initArrayLevel( output output_: eTplOutput ) -> stArrayLevels {
        var arrayLevels_ = stArrayLevels()
        for level_ in eTplLevel.allCases {
            let outputLevel_ = cTplOutputLevel( output_, level_, status: .eNotImplemented )
            arrayLevels_._levels.append( outputLevel_ )
        }
        return arrayLevels_
    }
}
