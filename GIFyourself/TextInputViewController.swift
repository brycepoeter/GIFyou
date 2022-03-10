//
//  TextInputViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/10/22.
//

import UIKit

class TextInputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        


        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "textToNext") {
            let nextViewController = segue.destination as! FontsViewController
            nextViewController.passedText = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "textToNext", sender: self)
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


