//
//  UserBasicSettings.swift
//  CoinSaver
//
//  Created by fiskirton on 13.12.2020.
//

import Foundation

final class BasicUserSettings {
    
    private enum SettingsKeys: String {
        case userEmail
        case userModel
        case isLoggedIn
        case isFirstLaunch
        case isDarkMode
        case signupUsers
    }
    
    static var userModel: UserModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data,
            let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel
            else {
                return nil
            }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userModel.rawValue
            
            if newValue == nil {
                defaults.set(nil, forKey: key)
            }
            
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
    
    static var userEmail: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userEmail.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userEmail.rawValue
            if let email = newValue {
                defaults.set(email, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var isLoggedIn: Bool!{
        get {
            return UserDefaults.standard.bool(forKey: SettingsKeys.isLoggedIn.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.isLoggedIn.rawValue
            if let isLoggedIn = newValue {
                defaults.set(isLoggedIn, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var isFirstLaunch: Bool!{
        get {
            return UserDefaults.standard.bool(forKey: SettingsKeys.isFirstLaunch.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.isFirstLaunch.rawValue
            if let isFirstLaunch = newValue {
                defaults.set(isFirstLaunch, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var isDarkMode: Bool!{
        get {
            return UserDefaults.standard.bool(forKey: SettingsKeys.isDarkMode.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.isDarkMode.rawValue
            if let isDarkMode = newValue {
                defaults.set(isDarkMode, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var signupUsers: [String : Bool]! {
        get {
            return UserDefaults.standard.object(forKey: SettingsKeys.signupUsers.rawValue) as? [String : Bool] ?? [:]
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.signupUsers.rawValue
            if let signupUsers = newValue {
                defaults.set(signupUsers, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
