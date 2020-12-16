//
//  AuthViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 13.11.2020.
//

import UIKit
import paper_onboarding

class AuthViewController: UIViewController {
    
    @IBAction func debugOnboarding(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboarding = sb.instantiateInitialViewController() as! OnboardingScreenViewController
        present(onboarding, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Authentication"
        // Do any additional setup after loading the view.
    }
    



}
