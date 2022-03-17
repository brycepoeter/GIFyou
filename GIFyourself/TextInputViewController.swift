//
//  TextInputViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class TextInputViewController: UIViewController, UITextFieldDelegate {
    /*
     ViewController for the first screen the user encounters. Essentially sets
     a logo and a textfield, takes in user text input, and sends it to the FontsVC
     so people can choose the font they want in the final GIF
     */

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
        self.navigationItem.hidesBackButton = true
        
        // If first time opening, show tutorial
        let timesAppOpened = UserDefaults.standard.string(forKey: "timesAppOpened")
        if timesAppOpened == "1" {
            let alert = UIAlertController(title: "How To Use", message: "1. Enter Text \n 2. Pick Font \n 3. Tap GIF to Copy", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
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
    
    // Handles nav and data passing when user hits enter on textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "fontsViewController") as! FontsViewController
        nextVC.passedText = textField.text
        self.navigationController?.pushViewController(nextVC, animated: true)
        print("TextInputVC sending text = \(textField.text?.debugDescription ?? "UNKNOWN") to FontsVC")
        return true
    }

}


