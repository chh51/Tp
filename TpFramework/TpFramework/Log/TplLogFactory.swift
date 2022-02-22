import Foundation
import Atomics

/// Static class with a single shared instance
public final class cTplLogFactory: Identifiable {
    
    /// Source for thread-safe sequential *id*
    private static var _lastId = ManagedAtomic<Int64>(0)

    public static let sharedFactory: cTplLogFactory = cTplLogFactory()
    
    /// Unique Identifiable.id within a process lifespan.
    /// Numbered sequentially from 1.  Unclear how the *id* would ever not be 1
    public let id: Int64 = _lastId.wrappingIncrementThenLoad(ordering: .sequentiallyConsistent)
    
    private var _arrayLog = [cTplLog]()
    
    /// Return the *cTplLog* for *eTplCategory*
    public func logForCategory( _ category_: eTplCategory ) -> cTplLog {
        let index_ = category_.arrayIndex
        precondition( 0 <= index_ && index_ < _arrayLog.count )
        let log_ = _arrayLog[ index_ ]
        precondition( log_.config.category == category_ )
        return log_
    }
    
    /// Single shared instance
    private init() {
        let dispatchQueue_ = DispatchQueue.global(qos: .utility )
        for category_ in eTplCategory.allCases {
            let categoryConfig_ = cTplCategoryConfig( category_ )
            let log_ = cTplLog(queue: dispatchQueue_, config: categoryConfig_ )
            _arrayLog.append( log_ )
        }
        _arrayLog.sort()
    }
}
