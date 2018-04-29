//
//  Stox_Unit_Tests.swift
//  Stox_Unit_Tests
//
//  Created by Puroof on 4/28/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import XCTest
@testable import Stox
import Mockingjay
import Alamofire

class Stox_Unit_Tests: XCTestCase {
    var resData: Data? = nil
    
    let jsonString = """
            {"symbol":"AAPL","companyName":"Apple Inc.","primaryExchange":"Nasdaq Global Select","sector":"Technology","calculationPrice":"close","open":164.07,"openTime":1524835800489,"close":162.32,"closeTime":1524859200408,"high":164.33,"low":160.63,"latestPrice":162.32,"latestSource":"Close","latestTime":"April 27, 2018","latestUpdate":1524859200408,"latestVolume":32828772,"iexRealtimePrice":162.3,"iexRealtimeSize":100,"iexLastUpdated":1524859195957,"delayedPrice":162.49,"delayedPriceTime":1524862794217,"previousClose":164.22,"change":-1.9,"changePercent":-0.01157,"iexMarketPercent":0.04998,"iexVolume":1640782,"avgTotalVolume":32691754,"iexBidPrice":0,"iexBidSize":0,"iexAskPrice":0,"iexAskSize":0,"marketCap":823613790160,"peRatio":16.68,"week52High":183.5,"week52Low":142.2,"ytdChange":-0.05386146578029324}"
            """
    
    let jsonBody =
        ["symbol":"AAPL","companyName":"Apple Inc.","primaryExchange":"Nasdaq Global Select","sector":"Technology","calculationPrice":"close","open":164.07,"openTime":1524835800489,"close":162.32,"closeTime":1524859200408,"high":164.33,"low":160.63,"latestPrice":162.32,"latestSource":"Close","latestTime":"April 27, 2018","latestUpdate":1524859200408,"latestVolume":32828772,"iexRealtimePrice":162.3,"iexRealtimeSize":100,"iexLastUpdated":1524859195957,"delayedPrice":162.49,"delayedPriceTime":1524862794217,"previousClose":164.22,"change":-1.9,"changePercent":-0.01157,"iexMarketPercent":0.04998,"iexVolume":1640782,"avgTotalVolume":32691754,"iexBidPrice":0,"iexBidSize":0,"iexAskPrice":0,"iexAskSize":0,"marketCap":823613790160,"peRatio":16.68,"week52High":183.5,"week52Low":142.2,"ytdChange":-0.05386146578029324] as [String : Any]

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        stub(everything, json(jsonBody))
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
    
    func testAddingSampleStockQuotes() {
        var stockQuotes = StockQuotes()
        stockQuotes.addSampleStockQuotes()
        let count = stockQuotes.count
        
        XCTAssert(count == 2, "Adding sample stocks to stocksQuotes did not increase count")
    }

    func testMockSession() {
        let url = "api.exchange.com"
        let session = MockSession()
        let client = HTTPClient(session: session)
        client.get(url: url) {
            (data, error) in
            self.resData = data
        }
        
        let pred = NSPredicate(format: "resData != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            
            XCTAssertNotNil(resData, "No data recived from the server for InfoView content")
        } else {
            XCTAssert(false, "The call to get the URL ran into some other error")
        }
    }
    
    func testAlamofireResponse() {
        let url = "https://httpbin.org/get"
        let e = expectation(description: "Alamofire")
        
        
        Alamofire.request(url).responseJSON { (response) in
            XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
            
            XCTAssertNotNil(response, "No response")
            
            if let data = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let stockQuote = try jsonDecoder.decode(StockQuote.self, from: data)
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
            
            XCTAssertNotNil(response.result.value, "No json value")
            if let json = response.result.value {
                print("JSON: \(json)")
                
            }
            
            
            
            
            XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
            
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
