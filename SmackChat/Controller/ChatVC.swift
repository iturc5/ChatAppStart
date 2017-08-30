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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)//this is to open a left side menu bar using reveal view contrller
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())//slide finger left gesture to open de menu too
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())//tep geture build in to close menu
        
    }

 

}
