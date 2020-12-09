//
//  ConfirmViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirmation"
        
        self.performSegue(withIdentifier: "afterGetStarted", sender: nil)
    }
    

    

}
