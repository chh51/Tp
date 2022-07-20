import Foundation
import TpFramework

public enum eTplMsgDebug : Int, CaseIterable, pTplMessageID {
    public static func < (lhs: eTplMsgDebug, rhs: eTplMsgDebug) -> Bool {
        return lessThan(lhs: lhs, rhs: rhs )
    }
    
    
    case eDebug1 = -100, eDebug2
    
    public var messageId: Int          { return self.rawValue      }
    public var level:     eTplLevel    { return eTplLevel.eDebug   }
    public var category:  eTplCategory { return eTplCategory.eTest }
}
