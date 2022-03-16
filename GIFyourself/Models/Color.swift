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
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    var invertedColor: UIColor {
        // If r/b/g is 0, keep it 0 inverted, that way it keeps whatever not-red/not-blue/not-green
        // designation was used by the random generator
        let red = 1 - self.rgba.0 //== 0 ? 0 : 1 - self.rgba.0
        let green = 1 - self.rgba.1 //== 0 ? 0 : 1 - self.rgba.1
        let blue = 1 - self.rgba.2 //== 0 ? 0 : 1 - self.rgba.2
        let newColor = UIColor(red: red, green: green, blue: blue, alpha: self.rgba.3)
        return newColor
    }
    
}
