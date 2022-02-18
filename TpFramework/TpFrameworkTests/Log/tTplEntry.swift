import XCTest
import TpFramework

final class tTplEntry: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEntry_1() throws {
        let l1 = aTplEntry(.eDefault, .eModel, "Simple message")
        XCTAssert( l1.level    == .eDefault )
        XCTAssert( l1.category == .eModel   )
        print( l1.message )
        
        let l2 = aTplEntry(.eDebug, .eModel, "l2: \(l1.message)")
        print( l2.message  )
        XCTAssert( l1.id < l2.id )
    }


}
