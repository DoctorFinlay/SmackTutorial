//
//  AuthService.swift
//  Smack
//
//  Created by Iain Coleman on 12/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AuthService {
    
    //Make this class a singleton - call it as AuthService.instance. when we need its variables or methods
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    //Create setters and getters for the variables we need
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    //The api has three steps to setup a new user - register, login and create. We need to create methods to perform these three steps
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        //Web requests are asynchronous - we don't wait for them to complete
        //Convert email to lower case in case of auto-capitalisation
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
// This is the native way of handling JSON without using SwiftyJSON
                //                if let json = response.result.value as? Dictionary<String, Any> {
                //                    if let email = json["user"] as? String {
                //                        self.userEmail = email
                //                    }
                //                    if let token = json["token"] as? String {
                //                        self.authToken = token
                //                    }
                
// This is equivalent to the code above, but using SwiftyJSON
                
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                } catch {
                    print(error)
                }

                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func createUser(name: String, email: String, avatarName: String, avatarColour: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColour
        ]
        
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }


    func setUserInfo(data: Data)   {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            UserDataService.instance.setUserData(id: id, colour: color, avatarName: avatarName, email: email, name: name)
        } catch {
            print(error)
        }
    }
    
    
    func changeUsername(newUsername: String, completion: @escaping CompletionHandler) {
        print("change username is running")
        
        let body = ["name" : "\(newUsername)"]
        
        let fullUrl = "\(URL_CHANGE_USERNAME)\(UserDataService.instance.id)"
        
        Alamofire.request(fullUrl, method: .put, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                print(data)
                
                do {
                    let json = try JSON(data: data)
                    let message = json["message"].stringValue
                    if message == "User info updated" {
                        completion(true)
                    }
                } catch {
                    print(error)
                }
                
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    


    
    
    
    

}
