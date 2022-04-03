//
//  SplashViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/16/22.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
        
    @IBOutlet weak var logo: UILabel!
    @IBOutlet weak var devName: UILabel!
    @IBOutlet weak var createdBy: UILabel!
    
    override func viewDidLoad() {
        self.drawBackground(width: self.view.bounds.width, height: self.view.bounds.height)
        
        // Set up logo
        logo.font = UIFont(name: "Lobster-Regular", size: 56)
        logo.textColor = .white
        self.logo.layer.shadowRadius = 4
        self.logo.layer.shadowOpacity = 0.5
        self.logo.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        // Set up name
        devName.font = UIFont(name: "LettownHills-Regular", size: 24)
        devName.textColor = .white
        self.devName.layer.shadowRadius = 4
        self.devName.layer.shadowOpacity = 0.5
        self.devName.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        // Set up created by
        createdBy.font = UIFont(name: "LettownHills-Regular", size: 24)
        createdBy.textColor = .white
        self.createdBy.layer.shadowRadius = 4
        self.createdBy.layer.shadowOpacity = 0.5
        self.createdBy.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        handleSettingsBundle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.transitionPage()
        })
    }
    
    @objc func transitionPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "textInputViewController") as! TextInputViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func handleSettingsBundle() {
        let firstOpened = UserDefaults.standard.string(forKey: "Initial Launch")
        if firstOpened == nil {
            let today = NSDate.now
            UserDefaults.standard.set(today.description, forKey: "Initial Launch")
            UserDefaults.standard.set("0", forKey: "timesAppOpened")
        }
        let timesAppOpened = Int(UserDefaults.standard.string(forKey: "timesAppOpened")!)
        UserDefaults.standard.set(timesAppOpened! + 1, forKey: "timesAppOpened")
        if timesAppOpened == 3 {
            let alert = UIAlertController(title: "Enjoying gifYou?", message: "Rate in App Store!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
