//
//  CircleView.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import UIKit

extension UIView {
    
    func initCircleView() {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true

        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
    
}
