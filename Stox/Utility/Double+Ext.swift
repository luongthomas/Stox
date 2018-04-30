//
//  Double+Ext.swift
//  Stox
//
//  Created by Puroof on 4/29/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import Foundation

// Source: https://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
