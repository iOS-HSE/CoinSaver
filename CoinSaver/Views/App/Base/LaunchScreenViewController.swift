//
//  LaunchScreenViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 13.12.2020.
//

import UIKit

class LaunchScreenViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userEmail = BasicUserSettings.userEmail
                
        if userEmail == nil {
            self.performSegue(withIdentifier: "AuthNavController", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "MainBoard", sender: nil)
        }
    }
}
