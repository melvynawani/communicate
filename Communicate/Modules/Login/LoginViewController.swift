//
//  LoginViewController.swift
//  Communicate
//
//  Created by Melvyn Awani on 06/04/2022.
//

import UIKit

protocol LoginViewControllerType {
    
    func segueToChatViewController()
}
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
            loginViewModel.performLogin(email: email, password: password) { response in
                
                switch response {
                case true:
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: UIButton.self)

                default:
                    let alertController = UIAlertController(title: "⚠️", message: Constants.loginFailMessage, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }
    


}

extension LoginViewController: LoginViewControllerType {
    func segueToChatViewController(){
        performSegue(withIdentifier: Constants.loginSegue, sender: UIButton.self)

    }
}
