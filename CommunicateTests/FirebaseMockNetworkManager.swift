//
//  FirebaseMockNetworkManager.swift
//  CommunicateTests
//
//  Created by Melvyn Awani on 11/04/2022.
//

import Foundation

@testable import Communicate


class FirebaseMockNetworkManager: FirebaseNetworkManagerType {
    func performSignUp(email: String, password: String, completionHandler: @escaping (Bool, String?) -> Void) {
        if email == "tommy@123.com" && password == "123456"{
            completionHandler(false, "Sign up failed")
        }
        else if email != "tommy@123.com" {
            completionHandler(true, "Sign up successful")
        }
    }
    
    func performLogin(userEmail: String?, password: String?, completionHandler: @escaping (Bool) -> Void) {
        if userEmail == "tommy@123.com" && password == "123456" {
            completionHandler(true)
        }
        else {
            completionHandler(false)
        }
    }
    
    func forgotPassword(userEmail: String?, completionHandler: @escaping (Bool) -> Void) {
        if userEmail == "tommy@123.com" {
            completionHandler(true)
        }
        else{
            completionHandler(false)
        }
    }
    
    func logOut() {
        print("Logged out")
    }
    
    }
