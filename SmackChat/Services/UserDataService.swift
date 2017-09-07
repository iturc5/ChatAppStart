//
//  UserDataService.swift
//  SmackChat
//
//  Created by David Ortiz on 9/6/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
// this is to update our avatar ones we selected the avatar
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
}
