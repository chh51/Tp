import XCTest
import TpFramework

final class tTplCategoryConfig: XCTestCase {

    func test_eTplOutput() throws {
        let arraySize_ = eTplOutput.arraySize()
        XCTAssert( arraySize_ == 4 )
        let eConsole_  = eTplOutput.eConsole
        XCTAssert( eConsole_.arrayIndex == 0 )
        
        var array_ = Array(repeating: 0, count: eTplOutput.arraySize() )
        XCTAssert( array_.count == eTplOutput.arraySize() )
        array_[ eConsole_.arrayIndex ]                 = 10
        array_[ eTplOutput.ePersistRemote.arrayIndex ] = 20
        array_[ eTplOutput.ePersistFile.arrayIndex   ] = 30
        array_[ eTplOutput.ePersistMemory.arrayIndex ] = 40
        
        XCTAssert( eConsole_.id == eConsole_.arrayIndex )
        
        var setDescriptions_: Set<String> = []
        for item_ in eTplOutput.allCases {
            setDescriptions_.insert( item_.description )
        }
        XCTAssert( setDescriptions_.count == arraySize_ )
    }

    func test_eTplLevel() throws {
        let arraySize_ = eTplLevel.arraySize()
        XCTAssert( arraySize_ == 5 )
        let eDebug_  = eTplLevel.eDebug
        XCTAssert( eDebug_.arrayIndex == 0 )
        
        var array_ = Array(repeating: 0, count: eTplLevel.arraySize() )
        XCTAssert( array_.count == eTplLevel.arraySize() )
        array_[ eDebug_.arrayIndex ]                   = 10
        array_[ eTplLevel.eInfo.arrayIndex ]           = 20
        array_[ eTplLevel.eDefault.arrayIndex   ]      = 30
        array_[ eTplLevel.eError.arrayIndex ]          = 40
        array_[ eTplLevel.eFault.arrayIndex ]          = 50

        XCTAssert( eDebug_.id == eDebug_.arrayIndex )
        
        var setDescriptions_: Set<String> = []
        for item_ in eTplLevel.allCases {
            setDescriptions_.insert( item_.description )
        }
        XCTAssert( setDescriptions_.count == arraySize_ )
        
        XCTAssert( eTplLevel.eDebug   <  eTplLevel.eInfo  )
        XCTAssert( eTplLevel.eFault   >  eTplLevel.eError )
        XCTAssert( eTplLevel.eDefault == eTplLevel.eDefault )
    }

    func test_cTplCategoryConfig() throws {
        let configModel_ = cTplCategoryConfig( .eModel )
        let configUI_    = cTplCategoryConfig( .eUI    )
        XCTAssert( configUI_.id != configModel_.id )
        
        let remoteDebug_ = configUI_.outputLevel( .ePersistRemote, .eDebug)
        XCTAssert( remoteDebug_.level  == .eDebug          )
        XCTAssert( remoteDebug_.output == .ePersistRemote  )
        XCTAssert( remoteDebug_.status == .eNotImplemented )
        XCTAssert( remoteDebug_.countActive == 0 )
        
        remoteDebug_.status = .eActive
        XCTAssert( remoteDebug_.status == .eActive )

    }
}
