//
//  GoalsViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit
import SwiftUI

class GoalsViewController: TabItemViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var goalCards: [GoalCard] = []
    
    override func setupTheme() {
        super.setupTheme()
        tableView.theme.backgroundColor = themed { $0.backgroundColor }
    }
    
    @objc func showNewGoalFormPopup(_ sender: UIButton) {
        let sb = UIStoryboard(name: "GoalFormPopup", bundle: nil)
        let popup = sb.instantiateInitialViewController() as! GoalCardFormPopup
        present(popup, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goalCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! GoalCardView
        
        cell.fillCard(cardData: goalCards[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            goalCards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Goals"
        self.addButton.initFloatingButton()
        self.addButton.addTarget(self, action: #selector(showNewGoalFormPopup), for: .touchUpInside)
        self.tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(forName: .saveCard, object: nil, queue: OperationQueue.main) {
            (notification) in
            let goalCardForm = notification.object as! GoalCardFormPopup
            let newCard = self.createCard(form: goalCardForm)
            
            if (newCard != nil) {
                self.goalCards.append(newCard!)
                self.tableView.reloadData()
            }
        }
    }
    
    func createCard(form: GoalCardFormPopup) -> GoalCard? {
        var dc: [String] = []
        for cell in form.dependentCostsList.visibleCells {
            let cell = cell as! GoalCardFormPopupCell
            if cell.isDependent.isOn {
                dc.append(cell.dependentCostLabel.text!)
            }
        }
        
        let goalTitle = form.goalTitleTextField.text
        let goalLimit = Int(form.goalLimit.text!)!
        
        if goalTitle!.count > 0 && dc.count > 0 {
            return GoalCard(Title: goalTitle!, goalLimit: goalLimit, dependentsCosts: dc)
        }
        
        return nil
    }

}

func getStatusValue(status: GoalStatus) -> String {
    switch status {
    case .notStarted:
        return "Not started"
    case .inProgress:
        return "In progress"
    case .achived:
        return "Achived"
    default:
        return "Unknown status"
    }
}

struct GoalCard {
    var Title: String
    var StatusLabel: String = "Status"
    var Status: GoalStatus = .notStarted
    var goalLimit: Int
    var dependentsCosts: [String]
}

enum GoalStatus {
    case notStarted
    case inProgress
    case achived
}
