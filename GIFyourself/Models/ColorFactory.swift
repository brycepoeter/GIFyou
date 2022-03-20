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
    
    public var generators: [() -> [UIColor]] = []
    
    private init() {
        generators = [
            self.freshAndBright,
            self.subduedAndProfessional,
            self.brightAndTropical,
            self.softInHue,
            self.seaOfSerenity,
//            self.healthyLeaves,
            self.sunlitEggplant,
            self.buddhistMonk
        ]
    }
    
    func makeAllCellColors() -> [[UIColor]] {
        var colors: [[UIColor]] = []
        for generator in generators {
            let palette = generator()
            colors.append(palette)
        }
        return colors
    }
    
    func freshAndBright() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(red: 249/255, green: 136/255, blue: 102/255, alpha: 1))
        colors.append(UIColor(red: 255/255, green: 66/255, blue: 14/255, alpha: 1))
        colors.append(UIColor(red: 128/255, green: 189/255, blue: 158/255, alpha: 1))
        colors.append(UIColor(red: 137/255, green: 218/255, blue: 89/255, alpha: 1))
        return colors.shuffled()
    }
    
    func subduedAndProfessional() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(red: 144/255, green: 175/255, blue: 197/255, alpha: 1))
        colors.append(UIColor(red: 51/255, green: 107/255, blue: 135/255, alpha: 1))
        colors.append(UIColor(red: 42/255, green: 49/255, blue: 50/255, alpha: 1))
        colors.append(UIColor(red: 118/255, green: 54/255, blue: 38/255, alpha: 1))
        return colors.shuffled()
    }
    
    func brightAndTropical() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(red: 245/255, green: 37/255, blue: 73/255, alpha: 1))
        colors.append(UIColor(red: 250/255, green: 103/255, blue: 117/255, alpha: 1))
        colors.append(UIColor(red: 255/255, green: 214/255, blue: 77/255, alpha: 1))
        colors.append(UIColor(red: 155/255, green: 192/255, blue: 28/255, alpha: 1))
        return colors.shuffled()
    }
    
    // https://www.canva.com/colors/color-palettes/soft-in-hue/
    func softInHue() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(hex: 0xF8C0C8))
        colors.append(UIColor(hex: 0xEFE7D3))
        colors.append(UIColor(hex: 0xD3BBDD))
        colors.append(UIColor(hex: 0xECE3F0))
        return colors.shuffled()
    }
    
    // https://www.canva.com/colors/color-palettes/sea-of-serenity/
    func seaOfSerenity() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(hex: 0x04ECF0))
        colors.append(UIColor(hex: 0x04D4F0))
        colors.append(UIColor(hex: 0x6AF2F0))
        colors.append(UIColor(hex: 0x059DC0))
        return colors.shuffled()
    }
    
    // https://www.canva.com/colors/color-palettes/healthy-leaves/
    func healthyLeaves() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(hex: 0x3D550C))
        colors.append(UIColor(hex: 0x81B622))
        colors.append(UIColor(hex: 0xECF87F))
        colors.append(UIColor(hex: 0x59981A))
        return colors.shuffled()
    }
    
    // https://www.canva.com/colors/color-palettes/sunlit-eggplant/
    func sunlitEggplant() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(hex: 0xEFD3B5))
        colors.append(UIColor(hex: 0x5F093D))
        colors.append(UIColor(hex: 0xB21368))
        colors.append(UIColor(hex: 0xD67BA8))
        return colors.shuffled()
    }
    
    // https://www.canva.com/colors/color-palettes/buddhist-monk/
    func buddhistMonk() -> [UIColor] {
        var colors: [UIColor] = []
        colors.append(UIColor(hex: 0xFBDD00))
        colors.append(UIColor(hex: 0xE9A200))
        colors.append(UIColor(hex: 0xB32800))
        colors.append(UIColor(hex: 0x7F0000))
        return colors.shuffled()
    }
}
