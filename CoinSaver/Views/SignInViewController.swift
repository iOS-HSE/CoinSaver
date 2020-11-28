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
    
    func signingIn() -> Bool{
        let email = loginInput.text!
        let password = passwordInput.text!
        var res = false
        if (!email.isEmpty && !password.isEmpty){
            Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                if error==nil{
                    res = true
                    self.performSegue(withIdentifier: "signinSuccess", sender: nil) } //костыль!
                else{
                    let alert = UIAlertController(title: "Ошибка", message: "Проверьте почту и пароль", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: false, completion: nil)
                }
            })
        }
        return res
    }
    
    
    @IBAction func signinAction(_ sender: Any) {
        if signingIn(){
        performSegue(withIdentifier: "signinSuccess", sender: nil)}
        
    }
    
    
}

extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if signingIn(){
        performSegue(withIdentifier: "signinSuccess", sender: nil)}
        return true
    }
}
