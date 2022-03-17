//
//  Color.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/15/22.
//

import Foundation
import UIKit

// https://www.hackingwithswift.com/example-code/uicolor/how-to-read-the-red-green-blue-and-alpha-color-components-from-a-uicolor
extension UIColor {
    /*
     These are some convenience methods for working with colors. RGBA returns
     the r/g/b/a values from a given color, which is useful for things like inversions.
     invertedColor returns a color with 1-r, 1-g, etc from the given color. So a color
     and its inverted color add up to r=1, g=1, etc. Alpha is kept at 1 for all.
     */
    
    // Gets the rgba values from a specific color
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    // Gives an "inverted" color with 1-original values for rgb
    var invertedColor: UIColor {
        let red = 1 - self.rgba.0 //== 0 ? 0 : 1 - self.rgba.0
        let green = 1 - self.rgba.1 //== 0 ? 0 : 1 - self.rgba.1
        let blue = 1 - self.rgba.2 //== 0 ? 0 : 1 - self.rgba.2
        let newColor = UIColor(red: red, green: green, blue: blue, alpha: self.rgba.3)
        return newColor
    }
    
}
