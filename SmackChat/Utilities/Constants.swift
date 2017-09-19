//
//  Constants.swift
//  SmackChat
//
//  Created by David Ortiz on 8/31/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import Foundation
//typealias is a remaping
typealias CompletionHandler = (_ Success: Bool) -> ()//this is a very simple closure means -> first class function that can be pasaround in code. to send a web request and wen is done they well recive the answer and it will say if is true or false

//URL constants
let BASE_URL = "https://chatiturc.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byemail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"

//colors
let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

//notification consstants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

//segues
let TO_LOGIN = "toLogin" // used for the cell identifier
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// headers
let HEADER = [//creating a Json object. we define the header that is -> application/json; charset=utf-8
    "Content-Type": "application/json; charset=utf-8"
]
let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
