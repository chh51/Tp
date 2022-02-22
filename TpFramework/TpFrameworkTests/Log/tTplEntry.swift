import XCTest
import TpFramework

final class tTplEntry: XCTestCase {

    func testEntry_1() throws {
        let l1 = cTplEntry(.eDefault, .eModel, "Simple message")
        XCTAssert( l1.level    == .eDefault )
        XCTAssert( l1.category == .eModel   )
        print( l1.message )
        
        let l2 = cTplEntry(.eDebug, .eModel, "l2: \(l1.message)")
        print( l2.message  )
        XCTAssert( l1.id < l2.id )
    }


}
