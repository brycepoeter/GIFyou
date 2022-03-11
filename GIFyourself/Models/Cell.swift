//
//  ColorCell.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/3/22.
//

import UIKit

import UIKit

class Cell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true

        self.container.addSubview(self.textView)
        self.textView.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        self.textView.centerYAnchor.constraint(equalTo: self.container.centerYAnchor).isActive = true
        self.textView.textAlignment = .center
        self.textView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.textView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

