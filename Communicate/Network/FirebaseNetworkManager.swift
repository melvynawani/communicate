//
//  FirebaseNetworkManager.swift
//  Communicate
//
//  Created by Melvyn Awani on 10/04/2022.
//

import Foundation
import Firebase

protocol FirebaseNetworkManagerType{
    func performLogin(userEmail: String?, password: String?,completionHandler:@escaping(_ response: Bool)->Void)
    func forgotPassword(userEmail: String?, completionHandler:@escaping(_ response: Bool)->Void)
    func performSignUp(email: String, password: String, completionHandler:@escaping (Bool, String?)->Void) 
    func logOut()

}

class FirebaseNetworkManager: FirebaseNetworkManagerType {
    
    func performLogin(userEmail: String?, password: String?,completionHandler:@escaping(_ response: Bool)->Void) {
        
        Auth.auth().signIn(withEmail: userEmail ?? "", password: password ?? "") { authResult, error in
            
            if  error != nil {
                completionHandler(false)
            }
            
            if Auth.auth().currentUser != nil {
                completionHandler(true)
            }
        }
        
    }
    
    func performSignUp(email: String, password: String, completionHandler:@escaping (Bool, String?)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error{
                completionHandler(false, e.localizedDescription)
            } else {
                completionHandler(true, nil)
                
            }
        }
        
    }
    
    func forgotPassword(userEmail: String?, completionHandler:@escaping(_ response: Bool)->Void) {
        Auth.auth().sendPasswordReset(withEmail: userEmail ?? "") { error in
            
            if  error != nil {
                completionHandler(false)
            }
            
            if error == nil {
                completionHandler(true)
            }
        }
        
    }
    
    func logOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
