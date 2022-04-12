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
    func performLogin(email: String, password: String, completionHandler:@escaping(_ response: Bool)->Void)}

class LoginViewModel: LoginViewModelType {
    private let firebaseNetworkManager: FirebaseNetworkManagerType
    
      init(firebaseNetworkManager: FirebaseNetworkManagerType){
          self.firebaseNetworkManager = firebaseNetworkManager
      }
    
    func performLogin(email: String, password: String, completionHandler:@escaping(_ response: Bool)->Void){
        firebaseNetworkManager.performLogin(userEmail: email, password: password, completionHandler:  { response in
            
            switch response {
            case true:
                completionHandler(true)
            default:
                completionHandler(false)
            }
            
        })
        
    }
    
    func forgotPassword(email: String, loginViewObject: LoginViewController){
        firebaseNetworkManager.forgotPassword(userEmail: email) { response in
            if response == true {
                let alertController = UIAlertController(title: "🔔", message: Constants.passwordResetSuccess , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                loginViewObject.present(alertController, animated: true, completion: nil)
            }
            else if response == false {
                let alertController = UIAlertController(title: "🔔", message: Constants.passwordResetFail, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                loginViewObject.present(alertController, animated: true, completion: nil)
            }
        }

    }
}
