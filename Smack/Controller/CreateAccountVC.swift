//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Iain Coleman on 11/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            
            if success {
                print("Registered User!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        print("Logged in user", AuthService.instance.authToken)
                    }
                })
            }
            
        }
        
        
        
    }
    
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
        
    }
    
    
    @IBAction func pickBGColourPressed(_ sender: Any) {
     
        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

}
