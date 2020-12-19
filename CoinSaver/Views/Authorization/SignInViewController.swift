//
//  SignInViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 13.11.2020.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var loginSucces: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        loginInput.delegate = self
        passwordInput.delegate = self
    }
    
    func signingIn() -> Bool {
        let email = loginInput.text!
        let password = passwordInput.text!
        if (!email.isEmpty && !password.isEmpty){
            Auth.auth().signIn(withEmail: email, password: password, completion: { [self] (result, error) in
                if (error != nil){
                    let alert = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: false, completion: nil)
                }
            })
        }
        else{
            let alert = UIAlertController(title: "Ошибка", message: "Все поля должны быть заполнены", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
        
        return true
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        if signingIn() {
            Auth.auth().addStateDidChangeListener({(auth, user) in
                if (user != nil){
                    let signupUsers = BasicUserSettings.signupUsers!
                    let userIsSignUp = signupUsers[(user?.email)!]
                    
                    if userIsSignUp == nil {
                        return
                    }
                    else if (!userIsSignUp!) {
                        self.performSegue(withIdentifier: "fromSignIn", sender: nil)
                        BasicUserSettings.userEmail = user?.email
                        BasicUserSettings.isLoggedIn = true
                    }
                    else {
                        BasicUserSettings.userEmail = user?.email
                        BasicUserSettings.isLoggedIn = true
                        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
                        let tabBarController = storyboard.instantiateViewController(identifier: "TabBar")
                        
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
                    }
                }
            })
        }
    }
}

extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        signingIn()
//        Auth.auth().addStateDidChangeListener({(auth, user) in
//            if (user != nil){
//                if (BasicUserSettings.isFirstLaunch) {
//                    self.performSegue(withIdentifier: "signInSuccess", sender: nil)
//                }
//                else {
//                    BasicUserSettings.userEmail = user?.email
//                    self.performSegue(withIdentifier: "fromSignIn", sender: nil)
//                }
//            }
//        })
        return true
    }
}
