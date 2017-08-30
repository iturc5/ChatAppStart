//
//  ChannelVC.swift
//  SmackChat
//
//  Created by David Ortiz on 8/29/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60// To show less content when the menu opens up

    }



}
