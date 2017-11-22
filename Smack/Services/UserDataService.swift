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
    
    func returnUIColor(components: String) -> UIColor {
        
        //Scanner class scans through a string for data - we tell it which characters to skip and where to go up to each time - the & in front of the variable is needed in the into: statement
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        //Scanner needs variables that are optional NSString values
        var r, g, b, a : NSString?
        
        scanner.scanCharacters(from: comma, into: &r)
        scanner.scanCharacters(from: comma, into: &g)
        scanner.scanCharacters(from: comma, into: &b)
        scanner.scanCharacters(from: comma, into: &a)

        //As r,g,b, and a are optional, we need to have a back up when we unwrap them
        let defaultColor = UIColor.lightGray
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = r else {return defaultColor}
        guard let bUnwrapped = r else {return defaultColor}
        guard let aUnwrapped = r else {return defaultColor}

        //Cannot convert directly from string to CGFloat, so have to do String to Double first
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        return newUIColor
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColour = ""
        email = ""
        name = ""
        
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
    
    
}
