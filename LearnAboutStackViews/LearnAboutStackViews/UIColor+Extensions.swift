//
//  UIColor+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/30/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension UIColor {

    var name: String {
        get {
            return UIColor.colorName(fromColor: self)
        }
    }

    class func colorName(fromColor color: UIColor) -> String {
        var cName = ""

        switch color {
            case UIColor.black:     cName = "black"
            case UIColor.blue:      cName = "blue"
            case UIColor.brown:     cName = "brown"
            case UIColor.clear:     cName = "clear"
            case UIColor.cyan:      cName = "cyan"
            case UIColor.darkGray:  cName = "darkGray"
            case UIColor.darkText:  cName = "darkText"
            case UIColor.gray:      cName = "gray"
            case UIColor.green:     cName = "green"
            case UIColor.lightGray: cName = "lightGray"
            case UIColor.lightText: cName = "lightText"
            case UIColor.magenta:   cName = "magenta"
            case UIColor.orange:    cName = "orange"
            case UIColor.purple:    cName = "purple"
            case UIColor.red:       cName = "red"
            case UIColor.white:     cName = "white"
            case UIColor.yellow:    cName = "yellow"
            default:                cName = rgbName(fromColor: color)
        }

        return cName
    }

    class func rgbName(fromColor color: UIColor) -> String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        var name = "(\(toByte(fromCGFloat: red)),\(toByte(fromCGFloat: green)),\(toByte(fromCGFloat: blue))"
        if alpha < 1.0 {
            name += ",\(toByte(fromCGFloat: alpha)))"
        } else {
            name += ")"
        }
        return name
    }

    class func toByte(fromCGFloat cgFloat: CGFloat) -> UInt8 {
        var value = cgFloat
        value = max(0.0, value)
        value = min(1.0, value)
        return UInt8(value * 255.0)
    }

}
