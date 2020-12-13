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
    
    @IBAction func logoutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print ("Sign out Error")
        }
        performSegue(withIdentifier: "toAuth", sender: nil)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        BasicUserSettings.isLoggedIn = false
        BasicUserSettings.isFirstLaunch = true
    }
    
}
