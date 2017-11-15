//
//  ChannelVC.swift
//  Smack
//
//  Created by Iain Coleman on 11/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}  //Allows other views to unwind to this view
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Sets how much of the rear screen is visible when the button is pressed
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //Makes sure user info is retrieved if user is logged in
        setupUserInfo()
    }
    
    
    @objc func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
    }
    
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named:UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColour)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            //Show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            //Show login VC
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    
}
