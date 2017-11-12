//
//  UserDataService.swift
//  Smack
//
//  Created by Iain Coleman on 12/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    //Other classes can get, only this class can set- data is safely encapsulated with public private(set)
    public private(set) var id = ""
    public private(set) var avatarColour = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""


    func setUserData(id: String, colour: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColour = colour
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    
}
