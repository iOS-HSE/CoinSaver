//
//  BudgetViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

// INTERNAL FUNCTIONS::::::::::::::::::::::::::::::::::::::::::::::

// getCategories() -> [BudgetCateory] return the list of categories defined on getting statred settings
// getBalance() -> int return current balance
// topUpBalance(int) -> bool return was balance changed or no
// makeSpending(BudgetCategory, in) -> bool return was spending made successfully or no

// END::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


import UIKit
struct BudgetCategory{
    var image: UIImage
    var type: String
}
class BudgetViewController: TabItemViewController {
    var selectedCategory: BudgetCategory? = nil
    
    var CategoryArray : [BudgetCategory] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topUpSumInput: UITextField!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var selectedCategoryName: UILabel!
    @IBOutlet weak var topUpButton: UIButton!
    @IBOutlet weak var spendingSumInput: UITextField!
    @IBOutlet weak var spendButton: UIButton!
    
    func showAlert(errorMessage: String){
        let alert = UIAlertController(title: "Message", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: false, completion: nil)
    }
    
    @IBAction func topUpAction(_ sender: Any) {
        var sumtoup: Int = 0
        sumtoup = Int(self.topUpSumInput.text ?? "0") ?? 0
        if (sumtoup == 0){
            showAlert(errorMessage: "Enter valid sum")
            return
        }
        
        if topUpBalance(sum: sumtoup){
            showAlert(errorMessage: "Your balance now is \(self.getBalance())")
            return
        }
        else{
            showAlert(errorMessage: "Check your internet connection!")
        }
        
    }
    
    @IBAction func spendAction(_ sender: Any) {
        if self.selectedCategory == nil{
            showAlert(errorMessage: "Choose category")
            return
        }
        let currentBalance = self.getBalance()
        do{
            let spendingSum = Int(self.spendingSumInput.text ?? "0") ?? 0
            if (spendingSum == 0){
                showAlert(errorMessage: "Enter valid sum")
            }
            else if (spendingSum > currentBalance){
                showAlert(errorMessage: "Insufficient funds")
            }
            else{
                if (!self.makeSpending(category: self.selectedCategory!, sum: spendingSum)){
                    showAlert(errorMessage: "Check your internet connection!")
                }
                else{
                    let category = selectedCategory?.type ?? "nothing"
                    showAlert(errorMessage: "Spent \(spendingSum) on \(category)")
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Budget"
        self.CategoryArray = self.getCategories()
    }

    func getCategories() -> [BudgetCategory]{
        let arr =  [BudgetCategory(image:UIImage(named: "first")!, type: "taxes")]
        return arr //TODO implement with UDef and Firebase with firebase
    }
       
    func getBalance() -> Int{
        return 10 //TODO implement with firebase and database
    }
    func topUpBalance(sum : Int) -> Bool{
        return false
    }

    func makeSpending(category: BudgetCategory, sum: Int) -> Bool{
        print (category.image.description+category.type+sum.description)
        return true
    }
    
    
}

extension BudgetViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BudgetCell", for: indexPath) as! CategoryCollectionViewCell
        cell.image.image = self.CategoryArray[indexPath.item].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCategory = CategoryArray[indexPath.item]
        self.categoryImage.image = self.selectedCategory?.image
        self.selectedCategoryName.text = self.selectedCategory?.type
    }
    
}

