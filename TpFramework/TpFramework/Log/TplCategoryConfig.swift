import Foundation
import Atomics

/// Configuration for a *eTplCategory*
///
///  Controls which *eTplOutput* and used for different *OSLogType*
public actor aTplCategoryConfig: Identifiable {

    /// Source for thread-safe sequential *id*
    private static var _lastId = ManagedAtomic<Int64>(0)
    
    /// Unique Identifiable.id within a process lifespan.
    /// Numbered sequentially from 1
    public nonisolated let id:          Int64 =
                _lastId.wrappingIncrementThenLoad(ordering: .sequentiallyConsistent)

    /// The *eTplCategory*
    public nonisolated let category:    eTplCategory
    
    public init( _      category_:      eTplCategory ) {
        category    = category_ 
    }
}
