//
//  ColorCell.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class ColorCell: Cell {
    
    var colors: [(UIColor, UIColor)]?
    var colorSwitches = 0
    
    override func didMoveToWindow() {
        // https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
        
    @objc func changeColors() {
        textView.backgroundColor = colors![self.colorSwitches % colors!.count].0
        textView.textColor = colors![self.colorSwitches % colors!.count].1
        colorSwitches += 1
    }
}