//
//  CircleImage.swift
//  Smack
//
//  Created by Iain Coleman on 12/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit

@IBDesignable // Allows us to see effects in Interface Builder

class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2 //If the image is a square, this will produce a circle
        self.clipsToBounds = true //Makes sure the image stays in the circle
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
