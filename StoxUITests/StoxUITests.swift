//
//  StoxUITests.swift
//  StoxUITests
//
//  Created by Puroof on 4/26/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import XCTest
@testable import Stox
import Mockingjay
import Alamofire

class StoxUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        setupStub()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func setupStub() {
        if let path = Bundle.main.path(forResource: "appleStockQuoteMock", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                
                stub(everything, jsonData(data))
            } catch let readErr {
                print("Error reading json: \(readErr)")
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCheckTitle() {
        let nav = app.navigationBars["Stock Quotes"]
        XCTAssert(nav.exists, "The stock quotes navigation bar does not exist")
    }
    
    func testNetflixDetailView() {
        let netflixRow = app.tables/*@START_MENU_TOKEN@*/.staticTexts["NFLX"]/*[[".cells.staticTexts[\"NFLX\"]",".staticTexts[\"NFLX\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let pred = NSPredicate(format: "exists == true")
        let exp = expectation(for: pred, evaluatedWith: netflixRow, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        XCTAssert(res == XCTWaiter.Result.completed, "Failed time out waiting for netflix Row")
        
        netflixRow.tap()
        let netflixNav = app.navigationBars["Netflix Inc."]
        XCTAssert(netflixNav.exists, "The Netflix nav bar did not change")
        
        netflixNav.buttons["Back"].tap()
        let mainNav = app.navigationBars["Stock Quotes"]
        XCTAssert(mainNav.exists, "The nav bar did not change back to the main view")
    }
    
    func testRefresh() {
        let netflixRow = app.tables/*@START_MENU_TOKEN@*/.staticTexts["NFLX"]/*[[".cells.staticTexts[\"NFLX\"]",".staticTexts[\"NFLX\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let pred = NSPredicate(format: "exists == true")
        let exp = expectation(for: pred, evaluatedWith: netflixRow, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        XCTAssert(res == XCTWaiter.Result.completed, "Failed time out waiting for netflix Row")
        
        app.buttons["Refresh"].tap()
        XCTAssertFalse(netflixRow.exists, "Refresh button did not clear the netflix row")
        let not_pred = NSPredicate(format: "exists == false")
        let not_exp = expectation(for: not_pred, evaluatedWith: netflixRow, handler: nil)
        let not_res = XCTWaiter.wait(for: [not_exp], timeout: 5.0)
        XCTAssert(not_res == XCTWaiter.Result.completed, "Failed time out waiting for netflix Row to remove itself")
        
        let refreshRes = XCTWaiter.wait(for: [exp], timeout: 5.0)
        XCTAssert(refreshRes == XCTWaiter.Result.completed, "Failed time out waiting for netflix Row after refresh")
    }
    
    func testEmptyStart() {
        XCTAssert(app.tableRows.count == 0, "Initialized stocks at start incorrectly")
    }
    
}
