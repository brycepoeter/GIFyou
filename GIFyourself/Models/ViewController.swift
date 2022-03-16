//
//  ViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/16/22.
//

import Foundation
import UIKit

extension UIViewController {
        
    // Color ideas: https://www.canva.com/learn/100-color-combinations/
    func drawBackground(width: CGFloat, height: CGFloat) {
        let renderer = UIGraphicsImageRenderer(bounds: self.view.bounds)
        let image = renderer.image { (context) in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
            // Top left
            UIColor(red: 230/255, green: 215/255, blue: 42/255, alpha: 1).setFill()
            context.fill(CGRect(x: 0, y: 0, width: width / 2, height: height / 2 + 100))
            // Top right
            UIColor(red: 241/255, green: 141/255, blue: 158/255, alpha: 1).setFill()
            context.fill(CGRect(x: width / 2, y: 0, width: 200, height: height / 2 - 70))
            // Bottom right
            UIColor(red: 152/255, green: 219/255, blue: 198/255, alpha: 1).setFill()
            context.fill(CGRect(x: width / 2 - 100, y: height / 2 - 70, width: width, height: height))
            // Bottom left
            UIColor(red: 25/255, green: 149/255, blue: 173/255, alpha: 1).setFill()
            context.fill(CGRect(x: 0, y: height / 2 + 100, width: width / 2 - 100, height: height / 2))
            // Middle
            UIColor(red: 91/255, green: 200/255, blue: 172/255, alpha: 1).setFill()
            context.fill(CGRect(x: width / 2 - 100, y: height / 2 - 70, width: width / 2 - (width / 2 - 100), height: height / 2 + 100 - (height / 2 - 70)))
        }
        let imageView = UIImageView(image: image)
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}
