//
//  NewGoalCardPopup.swift
//  CoinSaver
//
//  Created by fiskirton on 11.12.2020.
//

import UIKit

let zeroLimit = ErrorAlert(alertMessage: "Goal limit cannot be zero")
let zeroDependentCosts = ErrorAlert(alertMessage: "Goal should depend at least on one cost category")
let emptyGoalTitle = ErrorAlert(alertMessage: "Goal title cannot be empty")
let incorrectLimit = ErrorAlert(alertMessage: "Limit should be a number")

class GoalCardFormPopup: Popup, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var goalCardPopupView: UIView!
    @IBOutlet weak var goalTitle: UILabel!
    @IBOutlet weak var goalLimitTitle: UILabel!
    @IBOutlet weak var dependentCostsTitle: UILabel!
    
    
    @IBOutlet weak var goalTitleTextField: UITextField!
    @IBOutlet weak var dependentCostsList: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var goalLimit: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Consts.dependentCosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dependentCostCell", for: indexPath) as! GoalCardFormPopupCell
        
        cell.dependentCostLabel.text = Consts.dependentCosts[indexPath.row]
        cell.isDependent.setOn(false, animated: true)
        
        return cell
    }
    
    @IBAction func saveGoal(_ sender: UIButton) {
        if goalTitleTextField.text == "" {
            present(emptyGoalTitle.alert, animated: true, completion: nil)
            return
        }
        
        if checkLimitIsNumber() < 0 {
            present(incorrectLimit.alert, animated: true, completion: nil)
            return
        }
        
        if checkLimitIsNumber() == 0 {
            present(zeroLimit.alert, animated: true, completion: nil)
        }
        
        if countSelectedDependentCosts() == 0 {
            present(zeroDependentCosts.alert, animated: true, completion: nil)
            return
        }
        
        
        NotificationCenter.default.post(name: .saveCard, object: self)
        
        dismiss(animated: true)
    }
    
    
    @IBAction func cancelForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func countSelectedDependentCosts() -> Int {
        var count: Int = 0
        for cell in dependentCostsList.visibleCells {
            let cell = cell as! GoalCardFormPopupCell
            if cell.isDependent.isOn {
                count += 1
            }
        }
        
        return count
    }
    
    func checkLimitIsNumber() -> Int {
        let result =  Int(goalLimit.text!) ?? -1
        return result
    }
    
    
}
