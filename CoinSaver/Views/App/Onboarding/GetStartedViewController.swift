//
//  GetStartedViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import UIKit

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
        
        let userModel = UserModel(userEmail: BasicUserSettings.userEmail, userExpenseCategories: selectedCategories)
        BasicUserSettings.userModel = userModel
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.performSegue(withIdentifier: "fromGetStarted", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BasicUserSettings.isFirstLaunch = true
        BasicUserSettings.isLoggedIn = true
    }

}
