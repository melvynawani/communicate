//
//  Constants.swift
//  Communicate
//
//  Created by Melvyn Awani on 06/04/2022.
//

import Foundation

class Constants{
    static let appName = "💬 Communicate"
    static let loginSegue = "LoginToChat"
    static let signUpSegue = "SignUpToChat"
    static let chatCellIdentifier = "chatCell"
    static let chatCellNibName = "MessageTableViewCell"
    static let loginFailMessage = "Incorrect email address or password"
    static let passwordResetSuccess = "A password reset link has been sent to your email address"
    static let passwordResetFail = "Email address entered is not registered, please enter a registered email and then press 'Forgot Password' to reset your password"
    
    

    struct FirebaseStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
