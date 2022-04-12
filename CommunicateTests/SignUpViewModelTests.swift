//
//  SignUpViewModelTests.swift
//  CommunicateTests
//
//  Created by Melvyn Awani on 12/04/2022.
//

import XCTest
@testable import Communicate
class SignUpViewModelTests: XCTestCase {
    var firebaseMockNetwork = FirebaseMockNetworkManager()
    var signUpViewController = SignUpViewController()
    var signUpViewModel: SignUpViewModel!

    override func setUpWithError() throws {
        signUpViewModel = SignUpViewModel(firebaseNetworkManager: firebaseMockNetwork)
    }

    override func tearDownWithError() throws {
    }

    func testSignUpFail() {
            let userEmail = "tommy@123.com"
            let password = "123456"
        signUpViewModel.performSignUp(email: userEmail, password: password) { response, errorMessage in
            XCTAssertFalse(response)
            XCTAssertEqual("Sign up failed", errorMessage)

        }
    }
    
    func testSignUpPass() {
            let userEmail = "anonymous@123.com"
            let password = "123456"
        signUpViewModel.performSignUp(email: userEmail, password: password) { response, errorMessage in
            XCTAssertTrue(response)
         

        }
    }
}
