//
//  SettingsViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit
import Firebase

class SettingsViewController: TabItemViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        BasicUserSettings.isLoggedIn = false
        let storyboard = UIStoryboard(name: "AuthStoryboard", bundle: nil)
        let authViewController = storyboard.instantiateViewController(identifier: "AuthNavController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(authViewController)
//        BasicUserSettings.isFirstLaunch = true
    }
}
