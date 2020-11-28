//
//  ConfirmViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit

class ConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirmation"
        do{
            sleep(2)
        }
        performSegue(withIdentifier: "signupSuccess", sender: nil)
    }
    

    

}
