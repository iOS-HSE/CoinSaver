//
//  firebasefuncs.swift
//  CoinSaver
//
//  Created by administrator on 16/12/2020.
//

import Foundation
import Firebase

struct Goal{
    var name: String
    var categories: [String]
    var limit:Int
}

class FDatabase{
    var userdbref = Database.database().reference().child("users")
    init(email: String){
        userdbref = userdbref.child(email.replacingOccurrences(of: ".", with:"*"))
    }
    func setInfo(categories: [String], monthly: Int){
        userdbref.child("categories").setValue(categories)
        userdbref.child("monthly").setValue(monthly)
        userdbref.child("balance").setValue(0)
        userdbref.child("FundsHistory")
        upBalance(sum: monthly)
        
    }
    func setUsername(name: String){
        userdbref.child("login").setValue(name)
    }
    func upBalance(sum: Int){
        let current = userdbref.value(forKey: "balance") as! Int
        print(current)
        userdbref.child("balance").setValue(current+sum)
        let datef = DateFormatter()
        //let dateres = datef.date(from: "MM\YY")
        userdbref.child("FundsHistory")
    }
    func setGoals(goals: [Goal]){
        let goalsref = userdbref.child("Goals")
        for i in goals{
            goalsref.child(i.name).child("categories").setValue(i.categories)
            goalsref.child(i.name).child("limit").setValue(i.limit)
        }
    }
    func spend(category: String, sum: Int){
        
    }
    func getBalance() -> Int{
        return 7
    }
    func getUsername() -> String{
        return userdbref.value(forKey: "login") as! String
    }
    func getTotalSpendings() -> Int{
        return userdbref.value(forKey: "TotalSpendings") as! Int
    }
    func getTotalFunds() -> Int{
        return userdbref.value(forKey: "TotalFunds") as! Int
    }
    func getTotalSpendings(date: String) -> Int{
        let history = userdbref.value(forKey: "SpendingHistory") as! [String: Int]
        for sp in history{
            if sp.key == date{
                return sp.value
            }
        }
        return -1
    }
    func getTotalFunds(date: String) -> Int{
        let history = userdbref.value(forKey: "FundsHistory") as! [String: Int]
        for sp in history{
            if sp.key == date{
                return sp.value
            }
        }
        return -1
        
    }
    func getSpendingRate() -> [String: Int]{
        return userdbref.value(forKey: "SpendingRate") as! [String: Int]
    }
    func getSpendingRate(date: String) -> [String: Int]{
        let history = userdbref.value(forKey: "SpendingRate") as! [String: [String:Int]]
        for sp in history{
            if sp.key == date{
                return sp.value
            }
        }
        return ["No info":0]
    }
    func getGoals() -> [Goal]{
        let goals = userdbref.value(forKey: "Goals")
        print(goals.debugDescription)
        return []
    }
}
