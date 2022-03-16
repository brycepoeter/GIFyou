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
    var images: [UIImage] = []

//    override func didMoveToWindow() {
//        // https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
//        let timer = Timer.scheduledTimer(timeInterval: 0.67, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)
//        RunLoop.current.add(timer, forMode: .common)
//    }
//
//    @objc func changeColors() {
//        textView.backgroundColor = colors![self.colorSwitches % colors!.count]
//        textView.textColor = textView.backgroundColor?.invertedColor
//        colorSwitches += 1
//    }
//
//    func setImages() {
//        for color in self.colors! {
//            let cell = Cell()
//            let view = cell.contentView
//            cell.textView.backgroundColor = color
//            cell.textView.textColor = color.invertedColor
//            let uiImage = view.toImage()
//
//            self.images.append(uiImage)
//
//        }
//    }
}
