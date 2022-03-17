//
//  ColorFactory.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/15/22.
//

import Foundation
import UIKit

class ColorFactory {
    
    /*
     This is where most of the colors come from. The setBackground method in ViewController doesn't
     use this for colors, but everywhere else does. The way it works is it makes an array of arrays of
     UIColor. The [UIColor] is passed to an individual cell, and [[UIColor]].count equals the number
     of cells. Those passed colors are then what the cell uses to change its appearance. There are a
     few different generators here, basically color pickers, that determine cell appearance. On next
     iteration, generators could be written to provide more specific palettes rather than being so random,
     but as it stands, they provide distinct color patterns, though it can be hard to tell sometimes.
     */
    
    static let sharedInstance: ColorFactory = ColorFactory()
    public var fontCellColors = (["text": UIColor.black, "background": UIColor.white])
    
    public var generators: [() -> UIColor] = []
    
    private init() {
        self.generators = [
            self.random,
            self.randomNoRed,
            self.randomNoGreen,
            self.randomNoBlue,
            self.randomZeroToHalf,
            self.randomHalfToOne
        ]
    }
    
    // Generates the [[UIColor]] used by the entire collection view to color cells
    func makeAllCellColors(numColorsPerCell: Int) -> [[UIColor]] {
        var colors: [[UIColor]] = []
        self.generators.shuffle()
        for i in 0..<ColorFactory.sharedInstance.generators.count {
            let cellColors = makeCellColors(number: numColorsPerCell, generator: ColorFactory.sharedInstance.generators[i])
            colors.append(cellColors)
        }
        return colors
    }
    
    // Generates one cell worth of colors (number = number of color combos)
    func makeCellColors(number: Int, generator: () -> UIColor) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<number {
            let newColor = generator()
            colors.append(newColor)
        }
        return colors
    }
    
    // Generates truly random RGB values
    func random() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
        let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
        let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }

    // Generates random color with 0 in the R
    func randomNoRed() -> UIColor {
        let randRed = 0.0
        let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
        let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    // Generates random color with 0 in the G
    func randomNoGreen() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
        let randGreen = 0.0
        let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    // Generates random color with 0 in the B
    func randomNoBlue() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
        let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
        let randBlue = 0.0
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    // Generates random color only using 1...127 / 255 in RGB scale
    func randomZeroToHalf() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...127) / 255.0)
        let randGreen = CGFloat(Float.random(in: 0...127) / 255.0)
        let randBlue = CGFloat(Float.random(in: 0...127) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    // Generates random color only using 128...255 in RGB scale
    func randomHalfToOne() -> UIColor {
        let randRed = CGFloat(Float.random(in: 128...255) / 255.0)
        let randGreen = CGFloat(Float.random(in: 128...255) / 255.0)
        let randBlue = CGFloat(Float.random(in: 128...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    
}
