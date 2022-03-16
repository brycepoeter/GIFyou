//
//  ColorFactory.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/15/22.
//

import Foundation
import UIKit

class ColorFactory {
    
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
    
    func makeAllCellColors(numColorsPerCell: Int) -> [[UIColor]] {
        var colors: [[UIColor]] = []
        self.generators.shuffle()
        for i in 0..<ColorFactory.sharedInstance.generators.count {
            let cellColors = makeCellColors(number: numColorsPerCell, generator: ColorFactory.sharedInstance.generators[i])
            colors.append(cellColors)
        }
        return colors
    }
    
    func makeCellColors(number: Int, generator: () -> UIColor) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<number {
            let newColor = generator()
            colors.append(newColor)
        }
        return colors
    }
    
    func random() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
        let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
        let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    func randomNoRed() -> UIColor {
        let randRed = 0.0
        let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
        let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    func randomNoGreen() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
        let randGreen = 0.0
        let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    func randomNoBlue() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
        let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
        let randBlue = 0.0
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    func randomZeroToHalf() -> UIColor {
        let randRed = CGFloat(Float.random(in: 0...127) / 255.0)
        let randGreen = CGFloat(Float.random(in: 0...127) / 255.0)
        let randBlue = CGFloat(Float.random(in: 0...127) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    func randomHalfToOne() -> UIColor {
        let randRed = CGFloat(Float.random(in: 128...255) / 255.0)
        let randGreen = CGFloat(Float.random(in: 128...255) / 255.0)
        let randBlue = CGFloat(Float.random(in: 128...255) / 255.0)
        let alpha = 1.0
        let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
        return color
    }
    
    
}
