//
//  BudgetViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit
struct BudgetCategory{
    var image: UIImage
    var type: String
}
class BudgetViewController: TabItemViewController {
    ///TODO: load images
    var imageArray = [ UIImage(named: "first"),
                       UIImage(named: "first"),
                       UIImage(named: "first"),
                       UIImage(named: "first"),
                       UIImage(named: "first")
                       
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topUpSumInput: UITextField!
    @IBAction func topUpAction(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Budget"
    }

    func didSetCategory(category : BudgetCategory){
        
    }
    
    func getCategories() -> [BudgetCategory]{
        return []
    }
    
    func didChangeBalance(balance: Int) -> Bool{
        return false
    }
    
    func topUpBalance(sum : Int) -> Bool{
        return false
    }
    
    func didChangePrice(sum: Int) -> Bool{
        return false
    }
    
    func makeSpending(category: BudgetCategory, sum: Int) -> Bool{
        return false
    }
    
    
}

extension BudgetViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BudgetCell", for: indexPath) as! CategoryCollectionViewCell
        cell.image.image = imageArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/3)
    }
       
    
}

