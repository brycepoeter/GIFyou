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
    
//    func toImage() -> UIImage {
//        let renderer = UIGraphicsImageRenderer(bounds: bounds)
//        return renderer.image { rendererContext in
//            layer.render(in: rendererContext.cgContext)
//        }
//    }
    
    override func didMoveToWindow() {
        // https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
        let timer = Timer.scheduledTimer(timeInterval: 0.67, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
        
    @objc func changeColors() {
        textView.backgroundColor = colors![self.colorSwitches % colors!.count]
        textView.textColor = textView.backgroundColor?.invertedColor
        colorSwitches += 1
    }
    
    func setImages() {
        for color in self.colors! {
            let view = Cell()
            view.textView.backgroundColor = color
            view.textView.textColor = color.invertedColor
            view.saveAsJpeg(fileName: "/test.jpg")
            let jpg = UIImage(named: "test.jpg")
            let uiImage = view.toImage()
            print("jpg", jpg)
//            let ciImage = uiImage.cgImage()
            let context = CIContext(options: nil)
//            let cgImage = context.createCGImage(uiImage!, from: ciImage!.extent)!
            self.images.append(uiImage)
            
        }
    }
}
