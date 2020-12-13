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
    
    init(userEmail: String, userExpenseCategories: [String]) {
        self.userEmail = userEmail
        self.userExpenseCategories = userExpenseCategories
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userEmail, forKey: "userEmail")
        coder.encode(userExpenseCategories, forKey: "userExpenseCategories")
    }
    
    required init?(coder: NSCoder) {
        userEmail = coder.decodeObject(forKey: "userEmail") as? String ?? ""
        userExpenseCategories = coder.decodeObject(forKey: "userExpenseCategories") as? [String] ?? []
    }
    
    
}
