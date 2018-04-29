//
//  StockQuotes.swift
//  Stox
//
//  Created by Puroof on 4/28/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import Foundation

struct StockQuotes {
    private var quotes = [StockQuote]()
    
    var count:Int {
        return quotes.count
    }
    
    mutating func addSampleStockQuotes() {
        let appleStockQuote = StockQuote(symbol: "APPL", companyName: "Apple Inc.", open: 100, close: 130, high: 150, low: 100, latestPrice: 135.5, changePercent: 0.12)
        
        let googleStockQuote = StockQuote(symbol: "GOOG", companyName: "Google Inc.", open: 240, close: 325, high: 375, low: 159, latestPrice: 330, changePercent: 0.25)
        
        quotes.append(appleStockQuote)
        quotes.append(googleStockQuote)
    }
    
    mutating func removeSampleStockQuotes() {
        quotes.removeAll()
    }
    
    func itemAt(row: Int) -> StockQuote? {
        return quotes[row]
    }
}
