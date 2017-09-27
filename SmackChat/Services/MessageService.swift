//
//  MessageService.swift
//  SmackChat
//
//  Created by David Ortiz on 9/18/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    //this is the array were we will append the channels we create
    var channels = [Channel]()
    var messages = [Message]()//to get messages from the channels
    var selectedChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler){
        //making a request from the url... using the methots encoding and the header and the response
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                //new way to pharse trought JSON in swift 4
                //in channel.swift in the Model folder we need to add -> : Decodable next to the struct and we need to add all the values from the APIs as it is there with the same names
                //                do {
                //                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                //                } catch let error {
                //                    debugPrint(error as Any)
                //                }
                
                //turn json in tu an array eaasy way using swiftyJSON
                if let json = JSON(data: data).array {
                    //looping trough the full array of the API
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        //creating an object with the loop values (user data)
                        self.channels.append(channel)
                    }
//this notification is to let the app know that the user logged in so it will show the channels from the data base
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()//to clear the messages before get the new message data
                guard let data = response.data else { return }//unwraping the data making sure there is something in it
                if let json = JSON(data: data).array {//extracting the data that we get from the API or server
                    for item in json {//looping trough the API data
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        //adding the data to the message constant
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)//adding the message to the array
                    }
                    print(self.messages)
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
//to remove the channels after we logout
    func clearChannels(){
        channels.removeAll()
    }
//to remove the messages from the channels after we select different channels
    func clearMessages(){
        messages.removeAll()
    }
    
    
    
}

