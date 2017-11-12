//
//  Constants.swift
//  Smack
//
//  Created by Iain Coleman on 11/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation

//When we send a web request, we need to know if it completed or not - the completion handler is a closure that handles this
typealias CompletionHandler = (_ Success: Bool) -> ()

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"


//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//URL Constants

let BASE_URL = "https://billybig.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
