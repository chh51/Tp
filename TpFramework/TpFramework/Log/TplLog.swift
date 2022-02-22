import Foundation
import Atomics

/// Thread-safe handler for creating and routing *TplEntry*
public final class cTplLog: Identifiable, Equatable, Comparable {
    /// Source for thread-safe sequential *id*
    private static var _lastId = ManagedAtomic<Int64>(0)
    
    /// DispatchQueue to process cTplEntry upon
    private let        _dispatchQ:  DispatchQueue
    
    /// Configuration being supported
    public  let        config:      cTplCategoryConfig

    /// Unique Identifiable.id within a process lifespan.
    /// Numbered sequentially from 1
    public nonisolated let id:          Int64 =
    _lastId.wrappingIncrementThenLoad(ordering: .sequentiallyConsistent)
    
    /// If *eTplLevel* is active for any *eTplOutput*, create *cTplEntry* and process asynchronously
    /// - Parameters:
    ///   - level_: level of message *eTplLevel*
    ///   - message_:  Message body (may include interpolated strings)
    ///   - fileID_:  File location ( default provided )
    ///   - line_:  Line ( default provided )
    ///   - fxn_:  Function name ( default provided )
    public func log( _      level_:    eTplLevel,
                     _      message_:  String,
                     fileID fileID_:   String = #fileID,
                     line   line_:     Int    = #line,
                     fxn    fxn_:      String = #function ) {
        if !config.isLevelActive( level_ ) {
            return
        }
        let logEntry_ = cTplEntry( level_, config.category, message_, fileID: fileID_, line: line_, fxn: fxn_ )
        _dispatchQ.async {
            self.processLogEntry( logEntry_ )
        }
    }

    /// Initializer - internal access for use by *cTplLogFactory*
    /// - Parameters:
    ///   - queue_:  DispatchQueue to process *cTplEntry* on
    ///   - config_: Configuration 
    internal init( queue  queue_:     DispatchQueue,
                   config config_:    cTplCategoryConfig ) {
        _dispatchQ  = queue_
        config      = config_
    }
    
    /// Support for protocol *Equatable* to allow sorting in eTplCategory order
    static public func == (lhs: cTplLog, rhs: cTplLog) -> Bool {
        return lhs.id == rhs.id
    }
    /// Implement *Comparable* to allow sorting in eTplCategory order
    public static func < ( lhs: cTplLog, rhs: cTplLog ) -> Bool {
        return lhs.config.category.arrayIndex < rhs.config.category.arrayIndex
    }

    /// Process *cTplEntry* on each active output.  **Only run on DispatchQueue**
    private func processLogEntry( _ entry_: cTplEntry ) {
        for output_ in eTplOutput.allCases {
            let outputLevel_ = self.config.outputLevel( output_, entry_.level )
            if ( outputLevel_.status != .eActive ) {
                continue
            }
            switch( output_ ) {
            case .eConsole:
                self.outputConsole( entry_ )
            default:
                break
            }
        }
    }
    
    /// Output to Console.
    private func outputConsole( _ entry_: cTplEntry ) {
        let msg_ = "\(entry_.category.visualSymbol)" +
                   "\(entry_.level.visualSymbol)" +
                   "\(entry_.message)"
        print( msg_ )
    }
 }
