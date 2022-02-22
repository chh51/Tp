import XCTest
import TpFramework

class tTplLogFactory: XCTestCase {

   func testSingleFactory() {
       let factory1_ = cTplLogFactory.sharedFactory
       let factory2_ = cTplLogFactory.sharedFactory
       
       XCTAssert( factory1_.id == factory2_.id )
       XCTAssert( factory1_.id == 1 )
    }

    func testCorrectLog() {
        let factory_ = cTplLogFactory.sharedFactory
        XCTAssert( factory_.id == 1 )
        for category_ in eTplCategory.allCases {
            let log_ = factory_.logForCategory( category_ )
            XCTAssert( log_.config.category == category_ )
        }
    }

}
