//
//  GetStartedViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import UIKit

class ErrorAlert {
    let alert : UIAlertController
    
    init(alertMessage : String) {
        self.alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        self.alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
}

let zeroCategoriesAlert = ErrorAlert(alertMessage: "Number of categories cannot be null")
let nullBudgetAlert = ErrorAlert(alertMessage: "Budget cannot be null")

class GetStartedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var costCategoriesCV: UICollectionView!
    @IBOutlet weak var doneButton: UIButton!
    
    var userEmail: String?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Consts.dependentCosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CostCategoryCell
        
        let dependentCost = Consts.dependentCosts[indexPath.item]
                
        cell.categoryLabel.text = dependentCost
        cell.categoryIcon.initIconButton(icon: Consts.dependentCostsIcons[dependentCost]!!, background: Consts.dependentCostsColors[dependentCost]!)
            
        return cell
    }
    
    
    @IBAction func completeConfiguration(_ sender: Any) {
        var selectedCategories = [String]()
        for cell in costCategoriesCV.visibleCells {
            let cell = cell as! CostCategoryCell
            if cell.isSelected {
                selectedCategories.append(cell.categoryLabel.text!)
            }
        }
        
        let userModel = UserModel(userEmail: BasicUserSettings.userEmail, userExpenseCategories: selectedCategories, userBudget: Int(budgetTextField.text ?? "0") ?? 0)
        BasicUserSettings.userModel = userModel
        let fx = Int(budgetTextField.text ?? "0") ?? 0
        var dbref:FDatabase? = FDatabase(email: BasicUserSettings.userEmail)
        dbref?.setInfo(categories: selectedCategories, startBudget: Int(budgetTextField.text ?? "0") ?? 0)
        dbref = nil
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.performSegue(withIdentifier: "fromGetStarted", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BasicUserSettings.isFirstLaunch = true
        BasicUserSettings.isLoggedIn = true
    }

}
