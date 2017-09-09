//
//  CircleImage.swift
//  SmackChat
//
//  Created by David Ortiz on 9/9/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {
// all this is to make the profile image rounded
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}
