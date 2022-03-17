//
//  View.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/15/22.
//

import Foundation
import UIKit

extension UIView {
    
    /*
     This extension is what I use to convert the cells into images
     that are then turned into a GIF.
     */
    
    // Turns a view into a UIImage. This is used in ColorCell's setImages.
    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let img = renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        return img
    }
}
