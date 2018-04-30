//
//  StockQuote.swift
//  Stox
//
//  Created by Puroof on 4/27/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import Foundation

struct StockQuote: Decodable {
    let symbol: String
    let companyName: String
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    let latestPrice: Double
    let changePercent: Double
    var imageData: Data? = nil
}
