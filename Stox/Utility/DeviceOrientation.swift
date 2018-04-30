//
//  DeviceOrientation.swift
//  Stox
//
//  Created by Puroof on 4/29/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import UIKit

// Source: https://stackoverflow.com/questions/25796545/getting-device-orientation-in-swift
struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }}
