//
//  AuthService.swift
//  SmackChat
//
//  Created by David Ortiz on 9/4/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import Foundation

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard // saving data in the app

// to get and set the values and saved them using the (default) constant
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.bool(forKey: TOKEN_KEY) as! String
        }set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.bool(forKey: USER_EMAIL) as! String
        }set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
// end gets and sets
    
// registration func, using the complet handler from constants.swift
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()//making it lowercase
        
        let header = [//creating a Json object. we define the header that is -> application/json; charset=utf-8
            "Content-Type": "application/json; charset=utf-8"
        ]
        let body: [String: Any] = [// and here we define the body -> the same as it looks in the api
            "email": lowerCaseEmail,
            "password": password
        ]
 //creating a web request
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.defaults, headers: header).responseString{(response) in
            
            if response.result.error == nil {
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    
    }
  
}
