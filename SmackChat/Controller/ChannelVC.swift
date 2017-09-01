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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60// To show less content when the menu opens up

    }

    @IBAction func loginBtnPress(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)//the login button segue
    }
    

}
