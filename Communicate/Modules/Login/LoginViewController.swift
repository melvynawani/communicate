//
//  LoginViewController.swift
//  Communicate
//
//  Created by Melvyn Awani on 06/04/2022.
//

import UIKit
class LoginViewController: UIViewController {

    let loginViewModel: LoginViewModelType = LoginViewModel(firebaseNetworkManager: FirebaseNetworkManager())
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        if let email = emailTextField.text {
            loginViewModel.forgotPassword(email: email, loginViewObject: self)
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            loginViewModel.performLogin(email: email, password: password, loginViewObject: self)
        }
    }
    

}
