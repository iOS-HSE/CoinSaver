//
//  CostCategoryCellBudget.swift
//  CoinSaver
//
//  Created by fiskirton on 16.12.2020.
//

import UIKit

class CostCategoryCellBudget: CostCategoryCell {

    override func categorySelected(_ sender: UIButton) {
        NotificationCenter.default.post(name: .updateCategory, object: self)
    }
    
}
