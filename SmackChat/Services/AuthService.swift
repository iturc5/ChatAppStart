//
//  AuthService.swift
//  SmackChat
//
//  Created by David Ortiz on 9/4/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
            return defaults.value(forKey: TOKEN_KEY) as! String
        }set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
// end gets and sets
    
// registration func, using the complet handler from constants.swift
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()//making it lowercase
        
        let body: [String: Any] = [// and here we define the body -> the same as it looks in the api
            "email": lowerCaseEmail,
            "password": password
        ]
 //creating a web request
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString{(response) in
            
            if response.result.error == nil {
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    
    }
// LOGING USER
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        
       let lowerCaseEmail = email.lowercased()
        
       let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
//                //OLD FASHION WAY OF USING THE JSON LOGIN DATA WE EXTRACT FROM THE RESGITER REQUEST
//                if let json = response.result.value as? Dictionary<String, Any> {//setting up the jason api to the interface
//                    if let email = json["user"] as? String {// this is how we set the values from the data base to the user interface
//                        self.userEmail = email
//                    }
//
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
// end old fashing
// new and easy way to do it
                //we have to import swiftyJSON
                guard let data = response.data else {return}
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
//end new way
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
