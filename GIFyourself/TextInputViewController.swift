//
//  TextInputViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class TextInputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var logo: UILabel!
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var viewWidth: CGFloat = 0
    var viewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewWidth = self.view.bounds.width
        self.viewHeight = self.view.bounds.height
        
        self.drawBackground()
        
        // Logo
        self.logo.font = UIFont(name: "Lobster-Regular", size: 56)
        self.logo.textColor = .white
        self.logo.layer.shadowRadius = 4
        self.logo.layer.shadowOpacity = 0.75
        self.logo.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        // Text Field
        self.textField.delegate = self
        self.textField.font = UIFont(name: "LettownHills-Regular", size: 18)
        self.textField.layer.shadowRadius = 4
        self.textField.layer.shadowOpacity = 0.75
        self.textField.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.textField.bringSubviewToFront(self.view)
        self.textField.becomeFirstResponder()
        
        // Text Field Label
        self.textFieldLabel.font = UIFont(name: "LettownHills-Regular", size: 18)
        self.textFieldLabel.layer.shadowRadius = 4
        self.textFieldLabel.layer.shadowOpacity = 0.75
        self.textFieldLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.textFieldLabel.textColor = .white
        self.textFieldLabel.numberOfLines = 0
        
    }
    
    func drawBackground() {
        let renderer = UIGraphicsImageRenderer(bounds: self.view.bounds)
        let image = renderer.image { (context) in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
            // Top left
            UIColor(red: 230/255, green: 215/255, blue: 42/255, alpha: 1).setFill()
            context.fill(CGRect(x: 0, y: 0, width: self.viewWidth / 2, height: self.viewHeight / 2 + 100))
            // Top right
            UIColor(red: 241/255, green: 141/255, blue: 158/255, alpha: 1).setFill()
            context.fill(CGRect(x: self.viewWidth / 2, y: 0, width: 200, height: self.viewHeight / 2 - 70))
            // Bottom right
            UIColor(red: 152/255, green: 219/255, blue: 198/255, alpha: 1).setFill()
            context.fill(CGRect(x: self.viewWidth / 2 - 100, y: self.viewHeight / 2 - 70, width: self.viewWidth, height: self.viewHeight))
            // Bottom left
            UIColor(red: 25/255, green: 149/255, blue: 173/255, alpha: 1).setFill()
            context.fill(CGRect(x: 0, y: self.viewHeight / 2 + 100, width: self.viewWidth / 2 - 100, height: self.viewHeight / 2))
            // Middle
            UIColor(red: 91/255, green: 200/255, blue: 172/255, alpha: 1).setFill()
            context.fill(CGRect(x: self.viewWidth / 2 - 100, y: self.viewHeight / 2 - 70, width: self.viewWidth / 2 - (self.viewWidth / 2 - 100), height: self.viewHeight / 2 + 100 - (self.viewHeight / 2 - 70)))

        }
        let imageView = UIImageView(image: image)
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "fontsViewController") as! FontsViewController
        nextVC.passedText = textField.text
        self.navigationController?.pushViewController(nextVC, animated: true)
        return true
    }
    

}


