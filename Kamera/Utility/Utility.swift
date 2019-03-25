//
//  Utility.swift
//  Kamera
//
//  Created by OwenHong on 2019/3/25.
//  Copyright © 2019 owenhong. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        let hexString  = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r)/255.0
        let green = CGFloat(g)/255.0
        let blue = CGFloat(b)/255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var hexString: String? {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        let multiplier = CGFloat(255.999999)
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        if alpha == 1.0 {
            return String(format: "#%02lX%02lX%02lX", red * multiplier, green * multiplier, blue * multiplier)
        } else {
            return String(format: "#%02lX%02lX%02lX%02lX", red * multiplier, green * multiplier, blue * multiplier, alpha * multiplier)
        }
    }
}
