//
//  Message.swift
//  Smack
//
//  Created by Iain Coleman on 21/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation

struct Message : Decodable {
    
    //Using Swift 4 Decodable means we need our model to mirror the JSON object names exactly
    
    public private(set) var _id: String!
    public private(set) var messageBody: String!
    public private(set) var userId: String!
    public private(set) var channelId: String!
    public private(set) var userName: String!
    public private(set) var userAvatar: String!
    public private(set) var userAvatarColor: String!
    public private(set) var __v: Int
    public private(set) var timeStamp: String!
}
