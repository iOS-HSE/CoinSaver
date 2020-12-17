//
//  StartViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 13.12.2020.
//

import UIKit

class StartViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = BasicUserSettings.isLoggedIn
        let b = BasicUserSettings.isFirstLaunch
        
        if BasicUserSettings.isLoggedIn {
//            self.performSegue(withIdentifier: "toHome", sender: nil)
        }
        else {
//            self.performSegue(withIdentifier: "toAuth", sender: nil)
        }
        
    }

}
