//
//  GetStartedViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import UIKit

class GetStartedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var costCategoriesCV: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CostCategoryCell
        
        cell.categoryLabel.text = Array(Consts.dependentCosts.keys)[indexPath.item]
        cell.categoryIcon.image = Array(Consts.dependentCosts.values)[indexPath.item]
        
        return cell
    }
    
    
    @IBAction func completeConfiguration(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
