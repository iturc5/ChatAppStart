//
//  CreateAccountVC.swift
//  SmackChat
//
//  Created by David Ortiz on 9/2/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
