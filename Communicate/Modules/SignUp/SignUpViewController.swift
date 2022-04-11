//
//  SignUpViewController.swift
//  Communicate
//
//  Created by Melvyn Awani on 06/04/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    let signUpViewModel: SignUpViewModelType = SignUpViewModel()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        if let email = emailTextField.text , let password = passwordTextField.text{
            signUpViewModel.performSignUp(email: email, password: password, signUpViewObject: self)
        }
    }

}
