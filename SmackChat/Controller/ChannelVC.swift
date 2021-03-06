//
//  ChannelVC.swift
//  SmackChat
//
//  Created by David Ortiz on 8/29/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var loginBtn: UIButton!//outlet to change Login button to username
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}//this is to close the window were we are and go to the main view Controller after make this i have to do a segue on the storyboard
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60// To show less content when the menu opens up
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)// this is an observer tha manage the notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)//notif to let the app know that the channels will load
        tableView.delegate = self
        tableView.dataSource = self
//addinfg the channels top the table view from the socketService.swift file 
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
//to save the info in the app even if you close the app 2
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }

//this is to open the add channel xbis file and add a channel
    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelVCViewController()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func loginBtnPress(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
      //to show the XIBs view we create for the profile view
            let profile = ProfileVCViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)//the login button segue
        }
        
        
    }
 //selector functions
    @objc func userDataDidChange(_ notif: Notification){//this is an observer func were we set the new values to the user interface 
        setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notif: Notification){
        tableView.reloadData()
    }

// made this func to re-use the same code in multiple functions 
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)//calling the functions i made in userdataservise to change the profile background color from the scanner
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
//table view stuff we needed 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
//to show the conten of the channel
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]//asigned what we select to the variable channel
        MessageService.instance.selectedChannel = channel //then asigning the varible to whag we selected
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)//this will notify what channel we selected
        self.revealViewController().revealToggle(true)//the func to show the content
    }
    
    
    
    
    
}
