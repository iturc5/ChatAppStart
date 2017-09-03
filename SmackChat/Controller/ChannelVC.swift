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
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}//this is to close the window were we are and go to the main view Controller after make this i have to do a segue on the storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60// To show less content when the menu opens up

    }

    @IBAction func loginBtnPress(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)//the login button segue
    }
    

}
