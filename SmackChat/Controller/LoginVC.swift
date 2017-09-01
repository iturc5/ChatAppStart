//
//  LoginVC.swift
//  SmackChat
//
//  Created by David Ortiz on 8/31/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func closePress(_ sender: Any) {
        dismiss(animated: true, completion: nil)//to dissmiss a segue Login view
    }
    
}
