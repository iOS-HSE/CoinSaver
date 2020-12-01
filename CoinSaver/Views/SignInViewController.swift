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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        loginInput.delegate = self
        passwordInput.delegate = self
    }
    
    func signingIn(){
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
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        Auth.auth().addStateDidChangeListener({(auth, user) in
            if (user != nil){
                self.performSegue(withIdentifier: "signInSuccess", sender: nil)
            }
        })
        signingIn()
        
    }
    
    
}

extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Auth.auth().addStateDidChangeListener({(auth, user) in
            if (user == nil){
                self.performSegue(withIdentifier: "signInSuccess", sender: nil)
            }
        })
        signingIn()
        return true
    }
}
