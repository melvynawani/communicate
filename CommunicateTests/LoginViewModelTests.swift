//
//  LoginViewModelTests.swift
//  CommunicateTests
//
//  Created by Melvyn Awani on 11/04/2022.
//

import Foundation
import XCTest
@testable import Communicate

class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel!
    var firebaseMockNetwork = FirebaseMockNetworkManager()
    var loginViewController = LoginViewController()
    
    override func setUpWithError() throws {
        loginViewModel = LoginViewModel(firebaseNetworkManager: firebaseMockNetwork)
    }

    override func tearDownWithError() throws {
        
    }
    
    func testLoginValidationFail() {
            let userEmail = "anonymous@123.com"
            let password = "123456"
        firebaseMockNetwork.performLogin(userEmail: userEmail, password: password) { isLoginResponse in
            XCTAssertFalse(isLoginResponse)
        }
    }
    
    func testLoginValidationSuccess() {
        let userEmail = "tommy@123.com"
        let password = "123456"
        firebaseMockNetwork.performLogin(userEmail: userEmail, password: password) { isLoginResponse in
            XCTAssertTrue(isLoginResponse)
        }
    }
    
}
