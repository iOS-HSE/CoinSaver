//
//  BudgetViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit
import Foundation

class BudgetViewController: TabItemViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var totalSpent: UILabel!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var totalSpentTitle: UILabel!
    @IBOutlet weak var updateExpensesTitle: UILabel!
    
    var clickedCostCategoryName: String?
    var totalSpentNum: Int = 0
    
    override func setupTheme() {
        super.setupTheme()
        totalSpentTitle.theme.textColor = themed { $0.labelTextColor }
        updateExpensesTitle.theme.textColor = themed { $0.labelTextColor }
        totalSpent.theme.textColor = themed { $0.labelTextColor }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Budget"
        self.updateTotalSpent()
        
        NotificationCenter.default.addObserver(forName: .updateCategory, object: nil, queue: OperationQueue.main) {
            (notification) in
            let clickedCostCategory = notification.object as! CostCategoryCellBudget
            self.clickedCostCategoryName = clickedCostCategory.categoryLabel.text
            
            let sb = UIStoryboard(name: "AddExpensePopup", bundle: nil)
            let popup = sb.instantiateInitialViewController() as! AddExpensePopup
            self.present(popup, animated: true)
        }
        
        NotificationCenter.default.addObserver(forName: .saveExpense, object: nil, queue: OperationQueue.main) {
            (notification) in
            let updateExpensePopup = notification.object as! AddExpensePopup
            print("\(String(describing: self.clickedCostCategoryName)) was updated")
            self.totalSpentNum += Int(updateExpensePopup.expenseAmount.text ?? "0") ?? 0
            self.updateTotalSpent()
        }
        setupTheme()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for cell in categoriesCV.visibleCells {
            let cell = cell as! CostCategoryCellBudget
            cell.categoryLabel.theme.textColor = themed { $0.labelTextColor }
        }
    }
    
    func updateTotalSpent() {
        self.totalSpent.text = "\(self.totalSpentNum) / \(BasicUserSettings.userModel.userBudget)"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BasicUserSettings.userModel.userExpenseCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CostCategoryCellBudget
        
        let dependentCost = BasicUserSettings.userModel.userExpenseCategories[indexPath.item]
                
        cell.categoryLabel.text = dependentCost
        cell.categoryIcon.initIconButton(icon: Consts.dependentCostsIcons[dependentCost]!!, background: Consts.dependentCostsColors[dependentCost]!)
            
        return cell
    }

}
