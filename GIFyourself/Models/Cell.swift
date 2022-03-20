//
//  ColorCell.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/3/22.
//

import UIKit


class Cell: UICollectionViewCell {
    
    /*
     This is the base class for the display cells on the FontsView and ColorsView
     Essentially it's a place to put text with a background. FontsViewController
     uses this cell directly, and ColorsViewController uses a subclass of it
     */
    
    var colors: [UIColor]?
    var images: [UIImage] = []
    var colorChanges: Int = 0
    
    // Label where passed text shows up
    var textView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
//        self.contentView.widthAnchor.constraint(equalToConstant: (self.frame.width) * 0.9).isActive = true
//        self.contentView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        self.contentView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
//        self.contentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
//        self.contentView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true

        self.contentView.addSubview(self.textView)
        self.textView.textAlignment = .center
        self.textView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.textView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.textView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pickNextColor() {
        guard let colors = colors else { return }
        let index = colorChanges % colors.count
        self.textView.backgroundColor = colors[index]
        self.textView.textColor = colors[index].invertedColor
        colorChanges += 1
        if colorChanges == Int.max {
            colorChanges = 0
        }
    }
    
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

