//
//  TabItemViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit

class TabItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = self.navigationItem.title
    }
    
    func setupTheme() {
        view.theme.backgroundColor = themed { $0.backgroundColor }
        navigationController?.navigationBar.theme.barTintColor = themed { $0.accentColor }
        tabBarController?.tabBar.theme.barTintColor = themed { $0.backgroundColor }
    }
}
