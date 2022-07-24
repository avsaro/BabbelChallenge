//
//  BabbelChallengeUITests.swift
//  BabbelChallengeUITests
//
//  Created by Onur Avsar on 22.07.2022.
//

import XCTest

class BabbelChallengeUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testRoundTimer() throws {
        XCTAssertEqual(app.staticTexts["wrongAttempts"].label, "0")
        sleep(5)
        XCTAssertEqual(app.staticTexts["wrongAttempts"].label, "1")
    }
    
    func testCorrectTap() throws {
        app.buttons["Correct"].tap()
        let wrongAttempts = Int(app.staticTexts["wrongAttempts"].label) ?? 0
        let correctAttempts = Int(app.staticTexts["correctAttempts"].label) ?? 0
        let totalAttempts = wrongAttempts + correctAttempts
        XCTAssertEqual(totalAttempts, 1)
    }
    
    func testWrongTap() throws {
        app.buttons["Wrong"].tap()
        let wrongAttempts = Int(app.staticTexts["wrongAttempts"].label) ?? 0
        let correctAttempts = Int(app.staticTexts["correctAttempts"].label) ?? 0
        let totalAttempts = wrongAttempts + correctAttempts
        XCTAssertEqual(totalAttempts, 1)
    }
    
}
