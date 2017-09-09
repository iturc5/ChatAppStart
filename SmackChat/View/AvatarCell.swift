//
//  AvatarCell.swift
//  SmackChat
//
//  Created by David Ortiz on 9/7/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

enum AvatarType {//to choose with the seguemente controller
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        setupView()
    }
//setting the images and the background color
    func configureCell(index: Int, type: AvatarType){
        if type == AvatarType.dark{
            avatarImg.image = UIImage(named: "dark\(index)")//image name the index will be choose in avatarpicker.swift with the indexpath
            self.layer.backgroundColor = UIColor.lightGray.cgColor
    } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
    }
}
    
    func setupView(){//func to set up the BG color
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
}
