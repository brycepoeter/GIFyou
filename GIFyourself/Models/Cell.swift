//
//  ColorCell.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/3/22.
//

import UIKit


class Cell: UICollectionViewCell {
//    var container: UIView = {
//        let view = UIView()
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 4
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    var textView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        // Get rid of container, just do the same anchoring on contentView
        // For GIFS, take a look at CoreImage, maybe look for third party with simpler 
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.contentView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true

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
}

