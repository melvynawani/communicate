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
    func loadMessages(chatViewObject: ChatViewController)
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
        db.collection(K.FirebaseStore.collectionName).addDocument(data: [
            K.FirebaseStore.senderField: messageSender,
            K.FirebaseStore.bodyField: messageBody,
            K.FirebaseStore.dateField: Date().timeIntervalSince1970]) { error in
            if let e = error {
                print("There was an error while attempting to save data, \(e)")
            } else{
                print("Successfully saved data")
            }
        }
    }
    
    
    func loadMessages(chatViewObject: ChatViewController) {
        db.collection(K.FirebaseStore.collectionName).order(by: K.FirebaseStore.dateField).addSnapshotListener {[weak self] (querySnapshot, error) in
            self?.messages = []
            self?.uniqueSenders = []
            if let e = error {
                print("Error -> \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    
                    for document in snapshotDocuments {
                        let data = document.data()
                        if let sender = data[K.FirebaseStore.senderField] as? String, let messageBody = data[K.FirebaseStore.bodyField] as? String {
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
                                chatViewObject.tableView.reloadData()
                                let indexPath = IndexPath(row: (self?.messages.count ?? 1) - 1, section: 0)
                                chatViewObject.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                        
                    }
                }
                
            }
        }
    }
    
    
    
}
