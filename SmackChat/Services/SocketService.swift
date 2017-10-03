//
//  SocketService.swift
//  SmackChat
//
//  Created by David Ortiz on 9/20/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    override init() {
        super .init()
    }
    //open the conection between the app and the server
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    //stablish connection with the server
    func establishConnection(){
        socket.connect()
    }
    //closing the connection between the app an server
    func closeConnection(){
        socket.disconnect()
    }
    
    //sending the info from the app to the server ----> i have to take some info from the API to use it here name and order of the content
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    //reciving the information from the server ----> i have to take some info from the API to use it here name and order of the content
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler){
        let user = UserDataService.instance
        //send the message to the server
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        //recive the message from the server so it will showed to on the app
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
