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
        
        self.drawBackground(width: self.viewWidth, height: self.viewHeight)
        
        // Logo
        self.logo.font = UIFont(name: "Lobster-Regular", size: 56)
        self.logo.textColor = .white
        self.logo.layer.shadowRadius = 4
        self.logo.layer.shadowOpacity = 0.5
        self.logo.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        // Text Field
        self.textField.delegate = self
        self.textField.font = UIFont(name: "LettownHills-Regular", size: 18)
        self.textField.bringSubviewToFront(self.view)
        self.textField.becomeFirstResponder()
        
        // Text Field Label
        self.textFieldLabel.font = UIFont(name: "LettownHills-Regular", size: 18)
        self.textFieldLabel.textColor = .white
        self.textFieldLabel.numberOfLines = 0
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "fontsViewController") as! FontsViewController
        nextVC.passedText = textField.text
        self.navigationController?.pushViewController(nextVC, animated: true)
        return true
    }
    

}


