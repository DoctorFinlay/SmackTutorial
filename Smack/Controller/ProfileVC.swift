//
//  ProfileVC.swift
//  Smack
//
//  Created by Iain Coleman on 14/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var changeUserNameTxtField: UITextField!
    @IBOutlet weak var setButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColour)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        setButton.isEnabled = false
    }
    
    @objc func closeTap(_ recogniser:UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeUsernamePressed(_ sender: Any) {
        
        //Dismiss keyboard
        self.changeUserNameTxtField.resignFirstResponder()
        //Change username on backend
        guard let newName = self.changeUserNameTxtField.text else { return }
        AuthService.instance.changeUsername(newUsername: newName) { (success) in
            if success {
                print("User has changed name!")
            }
        }
        //Change Your Profile label
        self.userName.text = newName
        //Empty text field
        self.changeUserNameTxtField.text = ""
        

        
        
    }
    @IBAction func usernameTxtFieldChanged(_ sender: Any) {
        
        if changeUserNameTxtField.text != "" {
            setButton.isEnabled = true
        } else {
            setButton.isEnabled = false
        }
        
    }
}
