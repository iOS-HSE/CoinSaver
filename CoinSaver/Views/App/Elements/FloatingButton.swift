//
//  FloatingButton.swift
//  CoinSaver
//
//  Created by fiskirton on 06.12.2020.
//

import UIKit

extension UIButton {
    func initFloatingButton() {
        let icon = UIImage(named: "add")
        let tintedImage = icon?.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: .normal)
        tintColor = .darkGray
        
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }

}
