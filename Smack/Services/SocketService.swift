//
//  SocketService.swift
//  Smack
//
//  Created by Iain Coleman on 15/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit
import SocketIO

//Notice this service class is a subclass of NSObject!!

class SocketService: NSObject {

    //Needs to be a singleton
    static let instance = SocketService()
    
    //NSObject subclasses need initialiser
    override init() {
        super.init()
    }
    
//Create our socket and add open and close connection functions - these will then be started and stopped in AppDelegate when the app becomes active or terminates
    
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
//Channels and messages are controlled by sockets rather than Alamofire requests
//Socket emits are sent to server; socket ons are messages received from server
    
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        
        //Sends an event notification to the API called newChannel - this needs two items - name and description
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        
        // API event is as follows:  io.emit("channelCreated", channel.name, channel.description, channel.id);
        socket.on("channelCreated") { (dataArray, ack) in
            //ack = acknowledge
            //Parse what comes back into variables
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }

            //Add this new channel to our local list of channels
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: 0)
            MessageService.instance.channels.append(newChannel)
            completion(true)
            
            //We need to call this method from the ChannelVC ViewDidLoad
            
        }
    }
    
    
    func addMessage(messageBody: String, userID: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance //Just a timesaver!
        socket.emit("newMessage", messageBody, userID, channelId, user.name, user.avatarName, user.avatarColour)
        completion(true)
    }
    
    
    func getChatMessage(completion: @escaping (_  newMessage: Message) -> Void) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let messageId = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(_id: messageId, messageBody: messageBody, userId: "", channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, __v: 0, timeStamp: timeStamp)
            
            completion(newMessage)

        }
    }
    
   
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            
            //Pass users dictionary into completion handler
            completionHandler(typingUsers)
            
        }
    }
    
    
}
