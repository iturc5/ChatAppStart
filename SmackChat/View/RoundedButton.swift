//
//  RoundedButton.swift
//  SmackChat
//
//  Created by David Ortiz on 9/4/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0{//create the radius
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {//show it inmediatly
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {//to let the builder know that this was made from the original make
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView(){//setting up the corner to the item<button>
        self.layer.cornerRadius = cornerRadius
    }

}
