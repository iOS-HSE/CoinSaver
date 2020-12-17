//
//  GoalCardView.swift
//  CoinSaver
//
//  Created by fiskirton on 11.12.2020.
//

import UIKit

class GoalCardView: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValue: UILabel!
    @IBOutlet weak var goalProgress: UIProgressView!
    @IBOutlet weak var editCardButton: UIButton!
    var cardLimit: Int?
    
    func fillCard(cardData: GoalCard) {
        cardTitle.text = cardData.Title
        statusLabel.text = cardData.StatusLabel
        statusValue.text = getStatusValue(status: cardData.Status)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
