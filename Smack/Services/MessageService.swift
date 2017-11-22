//
//  MessageService.swift
//  Smack
//
//  Created by Iain Coleman on 14/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    //Creates an array of the Channel model class to store our channels
    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannels = [String]()
    var selectedChannel : Channel?
    
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
 
//SwiftJSON way...
                //                do {
                //                    if let json = try JSON(data: data).array {
                //                        //Get the relevant info for each channel and append it to the channels array
                //                        for item in json {
                //                            let name = item["name"].stringValue
                //                            let channelDescription = item["description"].stringValue
                //                            let id = item["_id"].stringValue
                //                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                //                            self.channels.append(channel)
                //                        }
                //                    }
                //                } catch {
                //                    print(error)
                //                }
                
// In Swift 4, we can do this a lot simpler, by making our Channel model conform to the Decodable protocol. The model has to match the JSON format exactly - all items must be included - see Channel.swift
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error{
                    debugPrint(error as Any)
                }
                print(self.channels)
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func clearChannels() {
        channels.removeAll()
    }
    
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                
                //Using Swift 4 Decoder :)
                do {
                    self.messages = try JSONDecoder().decode([Message].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                print(self.messages)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    
    func clearMessages() {
        messages.removeAll()
    }
}


