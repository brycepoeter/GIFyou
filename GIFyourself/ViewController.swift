//
//  ViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/3/22.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var textBox: UILabel!
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)
    }
    
    // https://stackoverflow.com/questions/35521396/swift-how-can-i-change-the-background-color-randomly-every-second
    @objc func changeColors() {
        let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
        let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
        let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
        view.backgroundColor = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: 1)
        textBox.textColor = UIColor(red: 1 - randRed, green: 1 - randGreen, blue: 1 - randBlue, alpha: 1)
    }


}

