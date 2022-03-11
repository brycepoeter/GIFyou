//
//  ColorCell.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class ColorCell: Cell {
    
    // timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)
    
    var colors: [(UIColor, UIColor)]?
    var colorSwitches = 0
    
    override func didMoveToWindow() {
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)
    }
        
    
    @objc func changeColors() {
        print("timer func fired")
        textView.backgroundColor = colors![self.colorSwitches % colors!.count].0
        textView.textColor = colors![self.colorSwitches % colors!.count].1
        colorSwitches += 1
    }
    
}
