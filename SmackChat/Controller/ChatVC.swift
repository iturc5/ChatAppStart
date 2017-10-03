//
//  ChatVC.swift
//  SmackChat
//
//  Created by David Ortiz on 8/29/17.
//  Copyright © 2017 David Ortiz. All rights reserved.


//error fix
//Click on the SWReveal..m file and look in the right hand pane under the file inspector. There should be a section for target membership, if the radio check box is not checked, check it and try again.

//revealviewcontroller.m to costumize the view

import UIKit

class ChatVC: UIViewController {
    
//outlets
    
    @IBOutlet weak var menuBtn: UIButton!//humburguer button
    @IBOutlet weak var chnnelNameLabel: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instansiate the keyboard binding file so the view goes up with the keyboard
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        //  end of closing the keyboard and binding the keyboard
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)//this is to open a left side menu bar using reveal view contrller
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())//slide finger left gesture to open de menu too
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())//tep geture build in to close menu
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDatadidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)//listiner of the changes
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
//to save the info in the app even if you close the app 1
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @objc func userDatadidChange(_ notif: Notification) {
        
        //will use the reusable func we create down here
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            //will show this if the user is logged out
            chnnelNameLabel.text = "Please Log In"
        }
    }
//selector function for the observer listener --> selector
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
//to close the keyboard with a tap when we are texting
    @objc func handleTap(){
        view.endEditing(true)
    }
//the func that will call the observer obove func channelselected --> & add the title of the channel we selected to the tableView title
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chnnelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    @IBAction func sendMsgPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTextBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                }
            })
        }
    }
    
    //reusable func
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success {//this means that if we are log in and theres channels created it will showed but if theres no channels it will show the messages on else statement
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.chnnelNameLabel.text = "No Channels Yet!"
                }
            }
        }
    }
//this is to get all the channels
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            
        }
    }
    
    
    
    
    
    
    
}
