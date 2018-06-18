//
//  PitchPerfectUITests.swift
//  PitchPerfectUITests
//
//  Created by Fernanda Araújo on 11/06/18.
//

import XCTest

class PitchPerfectUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRecordSoundAndGoAndBackToPlayView() {
        let app = XCUIApplication()
        
        app.buttons["Record"].tap()
        app.buttons["Stop"].tap()
        app.navigationBars["PitchPerfect.PlaySoundsView"].buttons["Back"].tap()
    }

    func testPlaySongButtons() {
        let app = XCUIApplication()
        app.buttons["Record"].tap()
        app.buttons["Stop"].tap()
        
        let stopButton = app.buttons["Stop"]
        
        app.buttons["Slow"].tap()
        stopButton.tap()
        app.buttons["Fast"].tap()
        stopButton.tap()
        app.buttons["HighPitch"].tap()
        stopButton.tap()
        app.buttons["LowPitch"].tap()
        stopButton.tap()
        app.buttons["Echo"].tap()
        stopButton.tap()
        app.buttons["Reverb"].tap()
        stopButton.tap()
    }
}
