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
// this is how we make a array of strings in to a color (avatarColor, in the ipa)
    func returnUIColor(components: String) -> UIColor {
        //scanner change a string in to another value like int or float or something like that
        let scanner = Scanner(string: components)// this is the scanner
        let skipped = CharacterSet(charactersIn: "[], ")//the items we dont want
        let comma = CharacterSet(charactersIn: ",")//the items we will skipped
        scanner.charactersToBeSkipped = skipped//characters the scanner will skipped
        
        var r, g, b, a : NSString?//this is how we make multiply variables in to one
        
        scanner.scanUpToCharacters(from: comma, into: &r)//starting to scan the variables
        scanner.scanUpToCharacters(from: comma, into: &g)//starting to scan the variables
        scanner.scanUpToCharacters(from: comma, into: &b)//starting to scan the variables
        scanner.scanUpToCharacters(from: comma, into: &a)//starting to scan the variables
        
        let defaultColor = UIColor.lightGray
        
        //but they are optionals we have to unwrapped
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        // now we have to convert them in to a CGFloat
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
}
