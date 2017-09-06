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

//segues
let TO_LOGIN = "toLogin" // used for the cell identifier
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// headers
let HEADER = [//creating a Json object. we define the header that is -> application/json; charset=utf-8
    "Content-Type": "application/json; charset=utf-8"
]
