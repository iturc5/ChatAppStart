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
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}

