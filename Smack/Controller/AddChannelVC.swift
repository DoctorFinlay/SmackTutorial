//
//  AddChannelVC.swift
//  Smack
//
//  Created by Iain Coleman on 15/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDescTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    
    func setupView() {
        //Allows tapping on bgview to dismiss modal
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(recogniser:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        chanDescTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    }
    
    
    @objc func closeTap(recogniser: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else { return }
        guard let channelDesc = chanDescTxt.text else { return }
        //This sends the new channel to the API, but we won't automatically get anything back - we need a Socket ON
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
              self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
}
