//
//  IconColorChange.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
      }
}
