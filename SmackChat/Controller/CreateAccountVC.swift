//
//  CreateAccountVC.swift
//  SmackChat
//
//  Created by David Ortiz on 9/2/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //outlest
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!//the loadding spinner sight
    
//variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?//to choose the profile img bgcolor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {//to reload the data selected from the avatarName image
        if UserDataService.instance.avatarName != "" {//to check if the user selECTED a item from the avatarName item
            userImg.image = UIImage(named: UserDataService.instance.avatarName)// seting up the interface with the code
            avatarName = UserDataService.instance.avatarName//and seting the image name and seting the item to the profile image
            
            if avatarName.contains("light") && bgColor == nil {//this is to set a lightGray color to the profile picture img if the user select a light gray img
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
// showing the loading spiner
        spinner.isHidden = false
        spinner.startAnimating()//indicated to start animating
        
//first step to conect the user interface with the web request it the i create in the authservice.swift
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                //to stop and hide the spinner ones we know everything was success
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)                            }
                        })
                    }
                })
            }
        }
        
        
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
//to create the random colors
    @IBAction func pickBGColor(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)//seting th random numbers from the variables in to the bgcolor variable
        UIView.animate(withDuration: 0.2){//giving an animation to the bgcolor change
        self.userImg.backgroundColor = self.bgColor//seting the final value to the userImg background
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setupView(){
//to indicated that is loading but here we hide it and we will show it when we click createAccountPress
        spinner.isHidden = true
//to change the placeholder color on the user interface smackPurplePlaceholder var i created in the constants file
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
//adding the function handleTap to the gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
//to close the keyboard
    @objc func handleTap(){
        view.endEditing(true)
    }





}
