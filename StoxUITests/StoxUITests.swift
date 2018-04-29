//
//  StoxUITests.swift
//  StoxUITests
//
//  Created by Puroof on 4/26/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import XCTest
@testable import Stox

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

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
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
    
    func testPressCompany() {
        app.tables.staticTexts["Apple Inc."].tap()
        let nav = app.navigationBars["Apple Inc."]
        XCTAssert(nav.exists, "The Apple Detail navigation bar does not exist")
    }
    
    func testImages() {
        
    }
    
    func testAddCompanies() {
        app.navigationBars["Stock Quotes"].buttons["AddCompanies"].tap()
        
        
    }
    
    func testAddRemoveCompanies() {
        
    }
    
    func testEmptyStart() {
        XCTAssert(app.tableRows.count == 0, "Initialized a company at start incorrectly")
    }
}
