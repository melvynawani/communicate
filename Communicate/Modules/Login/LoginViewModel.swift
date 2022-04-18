//
//  LoginViewModel.swift
//  Communicate
//
//  Created by Melvyn Awani on 08/04/2022.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelType {
    func forgotPassword(email: String, completionHandler:@escaping(_ response: Bool)->Void)
    func performLogin(email: String, password: String, completionHandler:@escaping(_ response: Bool)->Void)
    
}

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
    
    func forgotPassword(email: String, completionHandler:@escaping(_ response: Bool)->Void) {
        firebaseNetworkManager.forgotPassword(userEmail: email) { response in
            if response == true {
                completionHandler(true)
            }
            else if response == false {
                completionHandler(false)
            }
        }
    }
}
