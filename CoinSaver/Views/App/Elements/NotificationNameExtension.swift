//
//  NotificationNameExtension.swift
//  CoinSaver
//
//  Created by fiskirton on 11.12.2020.
//

import Foundation
extension Notification.Name {
    static let saveCard = Notification.Name(rawValue: "saveCard")
    static let saveDate = Notification.Name(rawValue: "saveDate")
    static let saveExpense = Notification.Name(rawValue: "saveExpense")
    static let updateCategory = Notification.Name(rawValue: "updateCategory")
}
