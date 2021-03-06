
import Foundation
import Atomics
import os

/// Log entry - immuatable
public final class cTplEntry: Identifiable {
    
    /// Source for thread-safe sequential *id*
    private static var _lastId = ManagedAtomic<Int64>(0)
    
    private static let _startTime = Date()
    
    /// Unique Identifiable.id within a process lifespan.
    /// Numbered sequentially from 1 (implements *Identifiable*)
    public let id:          Int64 = _lastId.wrappingIncrementThenLoad(ordering: .sequentiallyConsistent)
    
    /// OSLogType ( from lowest .debug to highest .fault )
    public let level:       eTplLevel
    
    /// The *eTplCategory*
    public let category:    eTplCategory
    
    /// Message as a string
    public let message:     String
    
    /// Message id (to group the same message purpose with different values)
    /// Default: 0 for non-specific messages
    public let messageId:   Int
    
    /// Date of message
    public let date:        Date
    
    /// TimeInterval since launch
    public let sinceLaunch: TimeInterval
    
    /// #fileID - name of file and module where it appears
    public let fileID:      String
    
    /// #line - line number of statement
    public let line:        Int
    
    /// #function - declaration where statement appears
    public let function:    String
    
    ///  Log entry with unique ID, time stamp, message, and origin location
    /// - Parameters:
    ///   - level_: level of message **eTplLevel**
    ///   - category_:  category of message **eTplCategory**
    ///   - message_:  Message body (may include interpolated strings)
    ///   - messageId_: Message number ( default to 0 )
    ///   - fileID_:  File location ( default provided )
    ///   - line_:  Line ( default provided )
    ///   - fxn_:  Function name ( default provided )
    public init( _      level_:      eTplLevel,
                 _      category_:   eTplCategory,
                 _      message_:    String,
                 _      messageId_:  Int    = 0,
                 fileID fileID_:     String = #fileID,
                 line   line_:       Int    = #line,
                 fxn    fxn_:        String = #function ) {
        let date_   = Date()
        level       = level_
        category    = category_
        message     = message_
        messageId   = messageId_
        date        = date_
        sinceLaunch = date_.timeIntervalSince( cTplEntry._startTime )
        fileID      = fileID_
        line        = line_
        function    = fxn_ 
    }
    
}
