import Foundation

public protocol pTplMessageID: Comparable {
    var messageId:      Int             { get }
    var level:          eTplLevel       { get }
    var category:       eTplCategory    { get }
}

public extension pTplMessageID {
    static func lessThan (lhs: any pTplMessageID,
                          rhs: any pTplMessageID) -> Bool {
        if lhs.category.rawValue < rhs.category.rawValue { return true }
        if lhs.level.rawValue    < rhs.level.rawValue    { return true }
        if lhs.messageId         < rhs.messageId         { return true }
        return false
    }

}

