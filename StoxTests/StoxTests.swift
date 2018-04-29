//
//  StoxTests.swift
//  StoxTests
//
//  Created by Puroof on 4/26/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import XCTest
@testable import Stox

class StoxTests: XCTestCase {
    
    let jsonString = """
            {"symbol":"AAPL","companyName":"Apple Inc.","primaryExchange":"Nasdaq Global Select","sector":"Technology","calculationPrice":"close","open":164.07,"openTime":1524835800489,"close":162.32,"closeTime":1524859200408,"high":164.33,"low":160.63,"latestPrice":162.32,"latestSource":"Close","latestTime":"April 27, 2018","latestUpdate":1524859200408,"latestVolume":32828772,"iexRealtimePrice":162.3,"iexRealtimeSize":100,"iexLastUpdated":1524859195957,"delayedPrice":162.49,"delayedPriceTime":1524862794217,"previousClose":164.22,"change":-1.9,"changePercent":-0.01157,"iexMarketPercent":0.04998,"iexVolume":1640782,"avgTotalVolume":32691754,"iexBidPrice":0,"iexBidSize":0,"iexAskPrice":0,"iexAskSize":0,"marketCap":823613790160,"peRatio":16.68,"week52High":183.5,"week52Low":142.2,"ytdChange":-0.05386146578029324}"
            """
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDecodableStockQuoteObject() {
        
        let jsonData = Data(self.jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        do {
            let stockQuote = try jsonDecoder.decode(StockQuote.self, from: jsonData)
            print(stockQuote)
            XCTAssertEqual(stockQuote.companyName, "Apple Inc.")
            XCTAssertEqual(stockQuote.symbol, "AAPL")
            XCTAssertEqual(stockQuote.changePercent, -0.01157)
            XCTAssertEqual(stockQuote.close, 162.32)
            XCTAssertEqual(stockQuote.high, 164.33)
            XCTAssertEqual(stockQuote.low, 160.63)
            XCTAssertEqual(stockQuote.latestPrice, 162.32)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testDecodableStockQuoteIncorrectValues() {
        
        let jsonData = Data(self.jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        do {
            let stockQuote = try jsonDecoder.decode(StockQuote.self, from: jsonData)
            print(stockQuote)
            XCTAssertNotEqual(stockQuote.companyName, "Apple Inc")
            XCTAssertNotEqual(stockQuote.symbol, "TSLA")
            XCTAssertNotEqual(stockQuote.changePercent, +0.211537)
            XCTAssertNotEqual(stockQuote.close, 500.0)
            XCTAssertNotEqual(stockQuote.high, 200.0)
            XCTAssertNotEqual(stockQuote.low, 0.0)
            XCTAssertNotEqual(stockQuote.latestPrice, -5.32)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testAddingSampleStockQuotes() {
        let stockController = StockController()
        stockController.addSampleStockQuotes()
        let count = stockController.stockQuotes.count
        
        XCTAssert(count == 3, "Adding sample stocks to stocksQuotes did not increase count")
    }
}
