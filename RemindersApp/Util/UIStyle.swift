//
//  UIStyle.swift
//  RemindersApp
//
//  Created by Jacob Rozell on 10/14/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import Foundation
import UIKit



enum UIMode {
    case Dark
    case Light
}

enum UIStyle {
    
    // Colors
    public static let navTintColor = UIColor(hex: "#0B2027", andAlpha: 1.0)
    public static let navBarTintColor = UIColor(hex: "#40798C", andAlpha: 1.0)
    
    public static let titleTextColor = UIColor.black
    
    public static let backgroundColor = UIColor(hex: "#DDDDDD", andAlpha: 1.0)
    
    public static let cellTextColor = UIColor.black//UIColor(hex: "#CFD7C7", andAlpha: 1.0)
    public static let cellSpaceBackgroundColor = UIColor(hex: "#DDDDDD", andAlpha: 1.0)//UIColor(hex: "#020201", andAlpha: 1.0)
    public static let cellBackgroundColor = UIColor.white//UIColor(hex: "#40798C", andAlpha: 1.0)
    
    public static let separatorColor = UIColor(hex: "#AAAAAA", andAlpha: 0.6)
    
    public static let popupBackgroundColor = UIColor.white
    public static let popupTextColor = UIColor(hex: "#CFD7C7", andAlpha: 1.0)
    
    public static let format = "MMM dd, yyyy"
    
    
//    public static let navTintColor = UIColor(hex: "#0B2027", andAlpha: 1.0)
//       public static let navBarTintColor = UIColor(hex: "#40798C", andAlpha: 1.0)
//       public static let navBarTextColor = UIColor.white
//       
//       public static let titleTextColor = UIColor.black
//       
//       public static let backgroundColor = UIColor(hex: "#020201", andAlpha: 1.0)
//       
//       public static let cellTextColor = UIColor.black//UIColor(hex: "#CFD7C7", andAlpha: 1.0)
//       public static let cellSpaceBackgroundColor = UIColor(hex: "#DDDDDD", andAlpha: 1.0)//UIColor(hex: "#020201", andAlpha: 1.0)
//       public static let cellBackgroundColor = UIColor.white//UIColor(hex: "#40798C", andAlpha: 1.0)
//       
//       public static let separatorColor = UIColor(hex: "#AAAAAA", andAlpha: 0.6)
//       
//       public static let popupBackgroundColor = UIColor.white
//       public static let popupTextColor = UIColor(hex: "#CFD7C7", andAlpha: 1.0)
//       
//       public static let format = "MMM dd, yyyy"
}

// this is how i want to grab the colors
//this.backgroundColor = UISTyle.mode.primary
