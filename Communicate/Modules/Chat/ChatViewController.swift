//
//  ChatViewController.swift
//  Communicate
//
//  Created by Melvyn Awani on 06/04/2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let chatViewModel: ChatViewModelType = ChatViewModel(firebaseNetworkManager: FirebaseNetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.chatCellNibName, bundle: nil), forCellReuseIdentifier: Constants.chatCellIdentifier)
        chatViewModel.loadMessages { response, indexPath in
            
            switch response {
            case true:
                self.tableView.reloadData()
                if let indexPath = indexPath {
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            default:
                print("Error Loading Messages")
            }
        }
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.view.frame.origin.y -= keyboardHeight
        }
        
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y = 0
        
    }
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        chatViewModel.logOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            chatViewModel.sendMessage(messageBody: messageBody, messageSender: messageSender)
        }
        messageTextField.text = ""
        messageTextField.resignFirstResponder()
    }
}

extension ChatViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatViewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatViewModel.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.chatCellIdentifier, for: indexPath) as! MessageTableViewCell
        if (message.sender == Auth.auth().currentUser?.email){
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageLabel.text = (message.body)
            cell.messageBubble.backgroundColor = .systemCyan
            cell.messageLabel.textColor = .white
            
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageLabel.text = (message.body)
            cell.messageBubble.backgroundColor = .systemFill
            cell.messageLabel.textColor = .black
            
        }
        return cell
    }
    
}


