//
//  SignUpViewModel.swift
//  Communicate
//
//  Created by Melvyn Awani on 08/04/2022.
//

import Foundation
import FirebaseAuth

protocol SignUpViewModelType {
    func performSignUp(email: String, password: String, signUpViewObject: SignUpViewController)
}

class SignUpViewModel: SignUpViewModelType {
 
    func performSignUp(email: String, password: String, signUpViewObject: SignUpViewController) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error{
                print (e.localizedDescription)
            } else{
                signUpViewObject.performSegue(withIdentifier: K.signUpSegue, sender: self)
            }
        }
        
    }
}
