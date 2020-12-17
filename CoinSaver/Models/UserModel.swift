//
//  UserModel.swift
//  CoinSaver
//
//  Created by fiskirton on 13.12.2020.
//

import Foundation

class UserModel: NSObject, NSCoding {
    
    let userEmail: String
    let userExpenseCategories: [String]
    let userBudget: Int
    
    init(userEmail: String, userExpenseCategories: [String], userBudget: Int) {
        self.userEmail = userEmail
        self.userExpenseCategories = userExpenseCategories
        self.userBudget = userBudget
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userEmail, forKey: "userEmail")
        coder.encode(userExpenseCategories, forKey: "userExpenseCategories")
        coder.encode(userBudget, forKey: "userBudget")
    }
    
    required init?(coder: NSCoder) {
        userEmail = coder.decodeObject(forKey: "userEmail") as? String ?? ""
        userExpenseCategories = coder.decodeObject(forKey: "userExpenseCategories") as? [String] ?? []
        userBudget = coder.decodeInteger(forKey: "userBudget")
    }
    
    
}
