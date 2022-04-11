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
    
    
    func forgotPassword(userEmail: String?, completionHandler:@escaping(_ response: Bool)->Void) {
        Auth.auth().sendPasswordReset(withEmail: userEmail ?? "") { error in
            
            if  error != nil {
                completionHandler(false)
            }
            
            if error == nil {
                completionHandler(true)
                print(error?.localizedDescription)
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
