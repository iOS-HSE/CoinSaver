//
//  NewGoalCardPopup.swift
//  CoinSaver
//
//  Created by fiskirton on 11.12.2020.
//

import UIKit

class GoalCardFormPopup: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Consts.dependentCosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dependentCostCell", for: indexPath) as! GoalCardFormPopupCell
        
        cell.dependentCostLabel.text = Array(Consts.dependentCosts.keys)[indexPath.row]
        cell.isDependent.setOn(false, animated: true)
        
        return cell
    }
    
    @IBOutlet weak var goalTitleTextField: UITextField!
    @IBOutlet weak var dependentCostsList: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveGoal(_ sender: UIButton) {
        NotificationCenter.default.post(name: .saveCard, object: self)
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
