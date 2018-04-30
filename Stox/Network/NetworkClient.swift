//
//  NetworkClient.swift
//  Stox
//
//  Created by Puroof on 4/29/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkClient {
    
    func fromNetworkCreateStockWith(url: String, completion: @escaping (StockQuote) -> Void){
        Alamofire.request(url).responseJSON { (response) in
            if let data = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let stock = try jsonDecoder.decode(StockQuote.self, from: data)
                    completion(stock)
                } catch let fetchErr {
                    print("Error fetching: \(fetchErr)")
                }
            }
        }
    }
}
