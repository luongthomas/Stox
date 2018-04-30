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
    
    override func setUp() {
        super.setUp()
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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAddingSampleStockQuotes() {
        var stockQuotes = StockQuotes()
        stockQuotes.addSampleStockQuotes()
        let count = stockQuotes.count
        
        XCTAssert(count == 2, "Adding sample stocks to stocksQuotes did not increase count")
    }
    
    func testCreateStockFromNetwork() {
        
        let stockSymbol = "TSLA"
        let urlCreate = URLCreate()
        let generatedUrl = urlCreate.createUrlFrom(stockSymbol: stockSymbol)

        fromNetworkCreateStockWith(url: generatedUrl) { (stockQuote) in
            XCTAssert(stockQuote.companyName == "Tesla Inc.", "Tesla Object not created properly")
        }
    }
    
    func fromNetworkCreateStockWith(url: String, completion: @escaping (StockQuote) -> Void){
        let e = expectation(description: "Alamofire")
        Alamofire.request(url).responseJSON { (response) in
            if let data = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let stock = try jsonDecoder.decode(StockQuote.self, from: data)
                    completion(stock)
                } catch {
                    print(error.localizedDescription)
                }
            }
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testAlamofireResponse() {
        setupStub()
        let url = "https://httpbin.org/get"
        let e = expectation(description: "Alamofire")
        
        Alamofire.request(url).responseJSON { (response) in
            XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
            XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
            XCTAssertNotNil(response, "No response")
            
            // Test Decoded Data
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
            
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCreateTeslaUrl() {
        let stockSymbol = "TSLA"
        let urlCreate = URLCreate()
        let generatedUrl = urlCreate.createUrlFrom(stockSymbol: stockSymbol)
        XCTAssertEqual(generatedUrl, "https://api.iextrading.com/1.0/stock/TSLA/quote", "Did not create the expecting URL for TSLA")
    }
    
    
}
