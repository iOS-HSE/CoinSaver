//
//  AddExpensePopup.swift
//  CoinSaver
//
//  Created by fiskirton on 16.12.2020.
//

import UIKit

class AddExpensePopup: Popup {

    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func saveExpense(_ sender: UIButton) {
        NotificationCenter.default.post(name: .saveExpense, object: self)
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
