//
//  Categories.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import Foundation
import UIKit

struct Consts {
    
    static let dependentCosts = [
        "Health",
        "Food",
        "Travels",
        "Entertainment",
        "Utility",
        "Technics",
        "Household",
        "Services",
        "Study"
    ]
    
    static let dependentCostsIcons = [
        "Health" : UIImage(named: "health"),
        "Food" : UIImage(named: "food"),
        "Travels" : UIImage(named: "travels"),
        "Entertainment" : UIImage(named: "entertainment"),
        "Utility" : UIImage(named: "utilities"),
        "Technics" : UIImage(named: "technics"),
        "Household" : UIImage(named: "household"),
        "Services" : UIImage(named: "services"),
        "Study" : UIImage(named: "study")
    ]
    
    static let dependentCostsColors = [
        "Health" : MaterialPalette.materialGreen,
        "Food" : MaterialPalette.materialYellow,
        "Travels" : MaterialPalette.materialBlue,
        "Entertainment" : MaterialPalette.materialRed,
        "Utility" : MaterialPalette.materialBrown,
        "Technics" : MaterialPalette.materialPurple,
        "Household" : MaterialPalette.materialTeal,
        "Services" : MaterialPalette.materialOrange,
        "Study" : MaterialPalette.materialPink
    ]
    
}

struct MaterialPalette {
    static let materialBlue = UIColor(hex: 0x2196f3)
    static let materialGreen = UIColor(hex: 0xaed581)
    static let materialRed = UIColor(hex: 0xe57373)
    static let materialPink = UIColor(hex: 0xff80ab)
    static let materialPurple = UIColor(hex: 0xce93d8)
    static let materialYellow = UIColor(hex: 0xfff176)
    static let materialOrange = UIColor(hex: 0xffb74d)
    static let materialBrown = UIColor(hex: 0xa1887f)
    static let materialTeal = UIColor(hex: 0x80cbc4)
    static let materialGreenDarker = UIColor(hex: 0x4caf50)
    static let materialBlack = UIColor(hex: 0x424242)
}
