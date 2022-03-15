//
//  ColorCell.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class ColorCell: Cell {
    
    var colors: [UIColor]?
    var colorSwitches = 0
    
    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    override func didMoveToWindow() {
        // https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
        
    @objc func changeColors() {
        textView.backgroundColor = colors![self.colorSwitches % colors!.count]
        textView.textColor = textView.backgroundColor?.invertedColor
        colorSwitches += 1
    }
}
