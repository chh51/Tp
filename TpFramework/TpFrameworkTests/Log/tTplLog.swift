import XCTest
import TpFramework

class tTplLog: XCTestCase {
    private var _factory = cTplLogFactory.sharedFactory

    override func setUpWithError() throws {
        XCTAssert( _factory.id == 1 )
        let logCore_        = _factory.logForCategory( .eTest )
        let config_         = logCore_.config
        for level_ in eTplLevel.allCases {
            let outputLevel_ = config_.outputLevel(.eConsole, level_ )
            _ = outputLevel_.statusSet( .eActive )
        }
    }
    
    override func tearDown() {
        Thread.sleep(forTimeInterval: TimeInterval(1.0))
    }

    func testConsole() {
        
        enum eTestMessage: Int, CaseIterable
              { case eInfo1 = 100, eInfo2, eDebug1, eDebug2, eDefault1, eError1, eFault1 }
        let logCore_        = _factory.logForCategory( .eTest )
        let config_         = logCore_.config
        let output_         = eTplOutput.eConsole
        let debugOL_        = config_.outputLevel( output_, .eDebug   )
        let infoOL_         = config_.outputLevel( output_, .eInfo    )
        let defaultOL_      = config_.outputLevel( output_, .eDefault )
        let errorOL_        = config_.outputLevel( output_, .eError   )
        let faultOL_        = config_.outputLevel( output_, .eFault   )
        let debugStart_     = debugOL_.countActive
        let infoStart_      = infoOL_.countActive
        let defaultStart_   = defaultOL_.countActive
        let errorStart_     = errorOL_.countActive
        let faultStart_     = faultOL_.countActive

        logCore_.log( .eFault,   "log 1 - eFault 1")
        logCore_.log( .eFault,   "log 2 - eFault 2")
        logCore_.log( .eDebug,   "log 3 - eDebug 1")
        logCore_.log( .eDefault, "log 4 - eDefault 1")
        logCore_.log(msgId: eTplMsgDebug.eDebug1   )
        logCore_.log( .eInfo,    "log 5 - eInfo 1")
        logCore_.log( .eError,   "log 6 - eError 1")
        logCore_.log( .eDebug,   "log 7 - eDebug 2")
        logCore_.log( .eFault,   "log 8 - eFault 3")
        logCore_.log( .eInfo,    "log 9 - eInfo 2")
        logCore_.log( .eDebug,   "log 10 - eDebug 3")
        logCore_.log( .eInfo,    "log 11 - eInfo 3")
        logCore_.log( .eFault,   "log 12 - eFault 4")
        logCore_.log(msgId: eTplMsgDebug.eDebug2, "eTpsMsgDebug.eDebug2")

        let debugEnd_       = debugOL_.countActive
        let infoEnd_        = infoOL_.countActive
        let defaultEnd_     = defaultOL_.countActive
        let errorEnd_       = errorOL_.countActive
        let faultEnd_       = faultOL_.countActive
        
        XCTAssert( debugStart_   + 5 == debugEnd_   )
        XCTAssert( infoStart_    + 3 == infoEnd_    )
        XCTAssert( defaultStart_ + 1 == defaultEnd_ )
        XCTAssert( errorStart_   + 1 == errorEnd_   )
        XCTAssert( faultStart_   + 4 == faultEnd_   )
    }

}
