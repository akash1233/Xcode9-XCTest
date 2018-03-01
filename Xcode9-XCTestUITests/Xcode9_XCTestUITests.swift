//
//  Xcode9_XCTestUITests.swift/
//  Xcode9-XCTestUITests
//
//  Created by Dharmendra Singh on 02/22/2018.
//  Copyright © 2018 Dharmendra Singh. All rights reserved.
//

import XCTest

class Xcode9_XCTestUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func waiterResultWithExpextation(_ element: XCUIElement) -> XCTWaiter.Result {
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: element,
                                        handler: nil)
        
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 5)
        return result
    }
    
    func testXCUISiriService() {
        if #available(iOS 10.3, *) {
            XCUIDevice().siriService.activate(voiceRecognitionText: "Open News")
        } else {
            // Fallback on earlier versions
        }
    }
    
    func testXCWaiterfeatures() {
        XCUIApplication().launch()
        let whatsNewButton = XCUIApplication().buttons["New"]
        whatsNewButton.tap()
        XCTAssertTrue(waiterResultWithExpextation(whatsNewButton) == .completed)
    }
    
    func testMultipleApps() {
        
        let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        XCUIApplication().launch()
        settingsApp.terminate()
        print(settingsApp.state.rawValue)
    }
    
    func testActivitiesScreenShotsAttachments() {
        XCTContext.runActivity(named: "Given I launch an Xcode9-XCTest app") { _ in
            XCUIApplication().launch()
        }
        
        XCTContext.runActivity(named: "When I tap what is new button") { _ in
            XCUIApplication().buttons["New"].tap()
        }
        
        XCTContext.runActivity(named: "Then I should see new features of XCTest") { _ in
            let newXCTestFeatures = XCUIApplication().staticTexts["There is a lot more to offer"]
            newXCTestFeatures.tap()
            XCTAssertTrue(newXCTestFeatures.exists)
        }
        
        XCTContext.runActivity(named: "When I use attachment to screenshot") { (activity) in
            let screen = XCUIScreen.main
            let fullscreenshot = screen.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .keepAlways
            activity.add(fullScreenshotAttachment)
        }
    }
}
