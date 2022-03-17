//
//  ColorCell.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class ColorCell: Cell {
    
    /*
     This is the cell that the ColorsViewController uses. Main difference between
     this and Cell is that this has colors and images attached to it that are used
     both for presentation and for making GIFs in GifFactory.
     */
    
    var colors: [UIColor]?
    var images: [UIImage] = []

    // Set the cell's UIImages. These will then be used by GifFactory to make a GIF
    func setImages(frame: CGRect, text: String, font: UIFont) {
        for color in self.colors! {
            self.textView.frame = frame
            self.textView.backgroundColor = color
            self.textView.text = text
            self.textView.font = font
            self.textView.textColor = color.invertedColor
            let uiImage = self.textView.toImage()
            self.images.append(uiImage)
        }
    }
}
