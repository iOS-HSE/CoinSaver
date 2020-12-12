//
//  addCardButton.swift
//  CoinSaver
//
//  Created by fiskirton on 11.12.2020.
//

import UIKit

let plusImage = UIImage(named: "add")

extension UIBarButtonItem {
    func getAddCardButton() {
        image = plusImage
        style = .plain
        target = self
        action = Selector(("btnTouched"))
        
        self.tintColor = .black
    }
}
