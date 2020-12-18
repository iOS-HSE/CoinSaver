//
//  GoalCardFormPopupCellTableViewCell.swift
//  CoinSaver
//
//  Created by fiskirton on 11.12.2020.
//

import UIKit

class GoalCardFormPopupCell: UITableViewCell {
    
    @IBOutlet weak var dependentCostLabel: UILabel!
    @IBOutlet weak var isDependent: UISwitch!
    
    func setupTheme() {
        dependentCostLabel.theme.textColor = themed { $0.labelTextColor }
        contentView.theme.backgroundColor = themed { $0.backgroundColor }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    

}
