//
//  Switcher.swift
//  CoinSaver
//
//  Created by fiskirton on 16.12.2020.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = BasicUserSettings.isLoggedIn
        var rootVC : UIViewController?
        

        if(status == true){
            rootVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
        }else{
            rootVC = UIStoryboard(name: "AuthStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
