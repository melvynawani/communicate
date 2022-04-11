//
//  LoginViewModel.swift
//  Communicate
//
//  Created by Melvyn Awani on 08/04/2022.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelType {
    func forgotPassword(email: String, loginViewObject: LoginViewController)
    func performLogin(email: String, password: String, loginViewObject: LoginViewController )
}

class LoginViewModel: LoginViewModelType {
    private let firebaseNetworkManager: FirebaseNetworkManagerType
    
      init(firebaseNetworkManager: FirebaseNetworkManagerType){
          self.firebaseNetworkManager = firebaseNetworkManager
      }
    
    func performLogin(email: String, password: String, loginViewObject: LoginViewController){
        firebaseNetworkManager.performLogin(userEmail: email, password: password, completionHandler:  { response in
            if response == true{
                loginViewObject.performSegue(withIdentifier: K.loginSegue, sender: UIButton.self)
                print(response)
            }
            else if response == false {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "⚠️", message: K.loginFailMessage, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
                    loginViewObject.present(alertController, animated: true, completion: nil)
                }
            }
            
        })
        
    }
    
    func forgotPassword(email: String, loginViewObject: LoginViewController){
        firebaseNetworkManager.forgotPassword(userEmail: email) { response in
            if response == true{
                let alertController = UIAlertController(title: "🔔", message: K.passwordResetSuccess , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                loginViewObject.present(alertController, animated: true, completion: nil)
            }
            else if response == false {
                let alertController = UIAlertController(title: "🔔", message: K.passwordResetFail, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                loginViewObject.present(alertController, animated: true, completion: nil)
            }
        }

    }
}
