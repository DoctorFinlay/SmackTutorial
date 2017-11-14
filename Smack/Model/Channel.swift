//
//  Channel.swift
//  Smack
//
//  Created by Iain Coleman on 14/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation

struct Channel : Decodable {
//    public private(set) var channelTitle: String!
//    public private(set) var channelDescription: String!
//    public private(set) var id: String!
// With SwiftyJSON we can call these what we want, but with Swift 4 Decodable, it has to mirror EXACTLY what we see in the JSON response.
    
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int //This is a mongoDB identifier - even though we don't need it in the app, we have to declare it in our model as it is in the JSON data that is returned to us, so Swift needs to be able to decode it


}
