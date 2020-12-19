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

    var cardLimit: Int?
    
    func fillCard(cardData: GoalCard) {
        cardTitle.text = cardData.Title
        statusLabel.text = cardData.StatusLabel
        goalProgress.setProgress(cardData.progressPercent, animated: true)
        updateStatus(status: cardData.Status)
    }
    
    func updateStatus(status: GoalStatus) {
        switch status {
        case .notStarted:
            statusValue.text = "Not started"
        case .good:
            statusValue.text = "Excellent progress"
            goalProgress.progressTintColor = MaterialPalette.materialGreen
        case .normal:
            statusValue.text = "Normal"
            goalProgress.progressTintColor = MaterialPalette.materialYellow
        case .dangerous:
            statusValue.text = "Close to the limit"
            goalProgress.progressTintColor = MaterialPalette.materialRed
        case .limit:
            statusValue.text = "Wasted"
            goalProgress.progressTintColor = MaterialPalette.materialBlack
        case .unknown:
            statusValue.text = "Unknown status"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
