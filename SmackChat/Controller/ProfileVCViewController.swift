//
//  ProfileVCViewController.swift
//  SmackChat
//
//  Created by David Ortiz on 9/14/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit
// this view will be in the xibs view

class ProfileVCViewController: UIViewController {
    
    //outlest
    @IBOutlet weak var profilesImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //logout i create the the func in the authService.swift file
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //to setup the ui interface with the code
    func setupView(){
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profilesImg.image = UIImage(named: UserDataService.instance.avatarName)
        profilesImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        //to close the view with a gesture recognizer with a tap outside the square
        //here we creted
        let closeTouch = UITapGestureRecognizer(target: self , action: #selector(ProfileVCViewController.closeTap(_:)))
        //here we added
        bgView.addGestureRecognizer(closeTouch)
    }
    //here we create the func to make the gesture recognizer work
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
