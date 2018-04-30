//
//  URLCreate.swift
//  Stox
//
//  Created by Puroof on 4/29/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import Foundation

struct URLCreate {
    let chosenStocks = ChosenStocks()
    
    func createUrlFrom(stockSymbol: String) -> String {
        if chosenStocks.symbols.contains(stockSymbol) {
            return "https://api.iextrading.com/1.0/stock/\(stockSymbol)/quote"
        } else {
            return "Not a known stock"
        }
        
    }
    
    func createImageUrlFrom(stockSymbol: String) -> String {
        if chosenStocks.symbols.contains(stockSymbol) {
            return "https://storage.googleapis.com/iex/api/logos/\(stockSymbol).png"
        } else {
            return "Not a known stock"
        }
    }
}
