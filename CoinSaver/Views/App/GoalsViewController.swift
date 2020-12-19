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
    let ref = FDatabase.getInstance()
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
            self.ref.setGoal(goal: Goal(name: newCard!.Title, categories: newCard!.dependentsCosts, limit: newCard!.goalLimit))
        }
    }
    
    func updateAllData(){
        let goalsFromDB = ref.getGoals()
        let categoriesSpendings = ref.getSpendingRate()
        self.goalCards = []
        goalsFromDB.forEach { (goal) in
                if (goal.name != "Empty"){
                var collectedSpendings = 0
                categoriesSpendings.forEach { (key: String, value: Int) in
                    if goal.categories.contains(key){
                        collectedSpendings += value
                    }
                }
                    
                    let spentPercent = Float(collectedSpendings) / Float(goal.limit)
                    self.goalCards.append(GoalCard(Title: goal.name, StatusLabel: "spent \(collectedSpendings) / limit: \(goal.limit)", Status: getStatus(value: spentPercent), goalLimit: goal.limit, dependentsCosts: goal.categories, progressPercent: spentPercent))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateAllData()
        self.tableView.reloadData()
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

func getStatus(value: Float) -> GoalStatus {
    if value == 0.0 {
        return .notStarted
    }
    else if value < 0.5 {
        return .good
    }
    else if value > 0.5 && value < 0.9 {
        return .normal
    }
    else if value >= 0.9 && value < 1.0 {
        return .dangerous
    }
    else if value >= 1.0 {
        return .limit
    }
    else {
        return .unknown
    }
}

struct GoalCard {
    var Title: String
    var StatusLabel: String = "Status"
    var Status: GoalStatus = .notStarted
    var goalLimit: Int
    var dependentsCosts: [String]
    var progressPercent: Float = 0.0
}

enum GoalStatus {
    case notStarted
    case good
    case normal
    case dangerous
    case limit
    case unknown
}
