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
    
//variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {//to reload the data selected from the avatarName image
        if UserDataService.instance.avatarName != "" {//to check if the user selECTED a item from the avatarName item
            userImg.image = UIImage(named: UserDataService.instance.avatarName)// seting up the interface with the code
            avatarName = UserDataService.instance.avatarName//and seting the image name and seting the item to the profile image
        }
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
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
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
        
        
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func pickBGColor(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
