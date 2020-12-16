//
//  iconButton.swift
//  CoinSaver
//
//  Created by fiskirton on 13.12.2020.
//

import Foundation
import UIKit

extension UIButton {
    func initIconButton(icon: UIImage, background: UIColor) {
        layer.cornerRadius = frame.height / 2
        let tintedIcon = icon.withRenderingMode(.alwaysTemplate)
        setImage(tintedIcon, for: .normal)
        backgroundColor = background
        tintColor = .darkGray
    }
}
