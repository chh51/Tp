import Foundation
import GRDB

///  Table *TypeItem*
///
///  defines the possible **Type** in table *DurableItem* via
///  foreign key **DiCiUId**
public struct TpmTypeItem: Identifiable, Equatable {
    /// Unique ID - supporting *Identifiable* protocol, same as *tiUId*
    public var id:     Int64? { get {return self.tiUId }}
    /// Unique ID - assigned when persisted to data store
    public let tiUId:  Int64?
    /// Type unique short name
    public let tiName: String
    /// Type unique description
    public let tiDesc: String
}
