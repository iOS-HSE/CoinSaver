//
//  CostCategoryCell.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import UIKit

class CostCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryIcon: UIButton!
    
    @IBAction func categorySelected(_ sender: UIButton) {
        self.isSelected = !self.isSelected
        
        if self.isSelected {
            self.backgroundColor = UIColor(hex: 0xFAD18C)
        }
        else {
            self.backgroundColor = UIColor(hex: 0xFDC446)
        }
    }
}
