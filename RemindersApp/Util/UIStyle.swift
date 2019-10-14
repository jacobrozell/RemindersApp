//
//  UIStyle.swift
//  RemindersApp
//
//  Created by Jacob Rozell on 10/14/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import Foundation
import UIKit

typealias Hex = String

enum UIStyle {
    enum LightMode: Hex {
        typealias RawValue = String
        
        case white = "#ffffff"
        case darkBlue = "#123456"
        case black = "#000000"
        
        func toColor() -> UIColor {
            return UIColor(hex: self.rawValue, andAlpha: 1.0)
        }
    }
    
    enum DarkMode: Hex {
        typealias RawValue = String
        
        case white = "#ffffff"
        case darkBlue = "#123456"
        case black = "#000000"
        
        func toColor() -> UIColor {
            return UIColor(hex: self.rawValue, andAlpha: 1.0)
        }
    }
}
