//
//  ChatViewModel.swift
//  Communicate
//
//  Created by Melvyn Awani on 08/04/2022.
//

import Foundation
import Firebase
import FirebaseAuth

protocol ChatViewModelType{
    var messages: [Message] {get}
    func logOut()
    func sendMessage(messageBody: String, messageSender: String)
    func loadMessages(completionHandler:@escaping (Bool, IndexPath?)->Void)
}



class ChatViewModel: ChatViewModelType {
    
    private let firebaseNetworkManager: FirebaseNetworkManagerType
      
      init(firebaseNetworkManager: FirebaseNetworkManagerType){
          self.firebaseNetworkManager = firebaseNetworkManager
      }
    
    var messages: [Message] = []
    var uniqueSenders: [String] = []
    let db = Firestore.firestore()

    func logOut(){
        firebaseNetworkManager.logOut()
    }
    
    func sendMessage(messageBody: String, messageSender: String) {
        db.collection(Constants.FirebaseStore.collectionName).addDocument(data: [
            Constants.FirebaseStore.senderField: messageSender,
            Constants.FirebaseStore.bodyField: messageBody,
            Constants.FirebaseStore.dateField: Date().timeIntervalSince1970]) { error in
            if let e = error {
                print("There was an error while attempting to save data, \(e)")
            } else{
                print("Successfully saved data")
            }
        }
    }
    
    func loadMessages(completionHandler:@escaping (Bool, IndexPath?)->Void) {
        db.collection(Constants.FirebaseStore.collectionName).order(by: Constants.FirebaseStore.dateField).addSnapshotListener {[weak self] (querySnapshot, error) in
            self?.messages = []
            self?.uniqueSenders = []
            if let e = error {
                print("Error -> \(e)")
                completionHandler(false, nil)
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    
                    for document in snapshotDocuments {
                        let data = document.data()
                        if let sender = data[Constants.FirebaseStore.senderField] as? String, let messageBody = data[Constants.FirebaseStore.bodyField] as? String {
                            let m1 = Message(sender: sender, body: messageBody)
                            self?.messages.append(m1)
                            for message in self!.messages {
                                if self!.uniqueSenders.contains(message.sender){
                                }
                                else{
                                    self?.uniqueSenders.append(message.sender)
                                    print("Added to uniquesender \(message.sender)")
                                }
                  
                            }
                            
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(row: (self?.messages.count ?? 1) - 1, section: 0)
                                completionHandler(true, indexPath)
                            }
                            
                        }
                        
                    }
                }
                
            }
        }
    }
    
    
    
}
