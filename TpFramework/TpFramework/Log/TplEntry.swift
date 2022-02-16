
import Foundation
import GRDB
import Atomics
import os

/// Log entry - immuatable
public actor aTplEntry: Identifiable {
    
    /// Source for thread-safe sequential *id*
    private static var _lastId = ManagedAtomic<Int64>(0)
    
    private static let _startTime = Date()
    
    /// Unique Identifiable.id within a process lifespan.
    /// Numbered sequentially from 1
    public nonisolated let id:          Int64 = _lastId.wrappingIncrementThenLoad(ordering: .sequentiallyConsistent)
    
    /// OSLogType ( from lowest .debug to highest .fault )
    public nonisolated let level:       OSLogType
    
    /// The *eTplCategory*
    public nonisolated let category:    eTplCategory
    
    /// Message as a string i
    public nonisolated let message:     String
    
    /// Date of message
    public nonisolated let date:        Date
    
    /// TimeInterval since launch
    public nonisolated let sinceLaunch: TimeInterval
    
    /// #fileID - name of file and module where it appears
    public nonisolated let fileID:      String
    
    /// #line - line number of statement
    public nonisolated let line:        Int
    
    /// #function - declaration where statement appears
    public nonisolated let function:    String
    
    public init( _      level_:    OSLogType,
                 _      category_: eTplCategory,
                 _      message_:  String,
                 fileID fileID_:   String = #fileID,
                 line   line_:     Int    = #line,
                 fxn    fxn_:      String = #function ) {
        let date_   = Date()
        level       = level_
        category    = category_
        message     = message_
        date        = date_
        sinceLaunch = date_.timeIntervalSince( aTplEntry._startTime )
        fileID      = fileID_
        line        = line_
        function    = fxn_ 
    }
    
}
