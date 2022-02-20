import Foundation
import Atomics

/// Thread-safe pair of *eTplOutput* and *eTplLevel*
public final class cTplOutputLevel: Identifiable, Equatable {
    
    /// Source for thread-safe sequential *id*
    private static var _lastId = ManagedAtomic<Int64>(0)
    
    /// Unique Identifiable.id within a process lifespan.
    /// Numbered sequentially from 1
    public nonisolated let id:          Int64 =
                _lastId.wrappingIncrementThenLoad(ordering: .sequentiallyConsistent)
    
    /// Which *eTplOutput* the *status* and *count* represent
    public  let  output:      eTplOutput
    
    /// Which *eTplLevel* the *status* and *count* represent
    public  let  level:       eTplLevel
    
    /// Thread-safe *eTplOutputStatus*
    private var  _status:     ManagedAtomic<eTplOutputStatus>
    
    /// Accessor to thread-safe *eTplOutputStatus*
    public  var  status:      eTplOutputStatus {
        get { return _status.load(ordering: .relaxed ) }
        set (newStatus_) { _status.store( newStatus_, ordering: .relaxed )}
    }
    
    /// Thread-safe count of processed *eTplEntry* while in *eTplOutputStatus.eActive*
    private var  _countActive = ManagedAtomic<Int>(0)
    
    /// Count of processed *eTplEntry* while in *eTplOutputStatus.eActive*
    public  var  countActive:      Int {
        get { return _countActive.load(ordering: .relaxed ) }
    }
    
    /// Thread-safe increment for *_countActive*
    internal func   incrementCountActive() {
        _countActive.wrappingIncrement(ordering: .relaxed )
    }
    
    /// Unique combination of *eTplOutput* and *eTplLevel*
    /// - Parameters:
    ///   - output_:  *eTplOutput*
    ///   - level_:   *eTplLevel*
    ///   - status_:  *eTplOutputStatus*
    public init( _      output_:    eTplOutput,
                 _      level_:     eTplLevel,
                 status status_:    eTplOutputStatus ) {
        output      = output_
        level       = level_
        _status     = ManagedAtomic<eTplOutputStatus>( status_ )
    }
    
    /// Implement *Equatable*
    public static func == (lhs: cTplOutputLevel, rhs: cTplOutputLevel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.output == rhs.output &&
        lhs.level == rhs.level &&
        lhs.status == rhs.status
    }
}
   
