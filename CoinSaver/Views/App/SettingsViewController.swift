//
//  SettingsViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit
import Firebase

class SettingsViewController: TabItemViewController {

    @IBOutlet weak var themeSwitcher: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!
    
    override func setupTheme() {
        super.setupTheme()
        themeLabel.theme.textColor = themed { $0.labelTextColor }
        themeSwitcher.theme.onTintColor = themed { $0.switcherColor}
        themeSwitcher.theme.thumbTintColor = themed { $0.switcherThumbColor}
    }
    
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
    
    @IBAction func themeChanged(_ sender: UISwitch) {
        if sender.isOn {
            themeService.switch(.dark)
        } else {
            themeService.switch(.light)
        }
    }
}
