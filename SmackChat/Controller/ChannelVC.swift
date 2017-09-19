//
//  ChannelVC.swift
//  SmackChat
//
//  Created by David Ortiz on 8/29/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //outlets
    @IBOutlet weak var loginBtn: UIButton!//outlet to change Login button to username
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}//this is to close the window were we are and go to the main view Controller after make this i have to do a segue on the storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60// To show less content when the menu opens up
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)//to do something with the login notidication

    }
//to save the info in the app even if you close the app 2
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
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
    
    @objc func userDataDidChange(_ notif: Notification){//this is an observer func were we set the new values to the user interface 
        setupUserInfo()
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
        }
    }
}
