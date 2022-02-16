import XCTest
import TpFramework

class tTplEntry: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let l1 = aTplEntry(.default, .eModel, "Simple message")
        XCTAssert( l1.level    == .default )
        XCTAssert( l1.category == .eModel  )
        print( l1.message )
        
        let l2 = aTplEntry(.debug, .eModel, "l2: \(l1.message)")
        print( l2.message  )
        XCTAssert( l1.id < l2.id )
    }


}
