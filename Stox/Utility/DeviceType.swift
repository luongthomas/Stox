//
//  DeviceType.swift
//  Stox
//
//  Created by Puroof on 4/29/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import UIKit

struct DeviceType {
    
    func isPad() -> Bool {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            return true
        } else {
            return false
        }
    }
    
}
