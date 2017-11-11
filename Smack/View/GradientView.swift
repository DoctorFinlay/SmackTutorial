//
//  GradientView.swift
//  Smack
//
//  Created by Iain Coleman on 11/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit

@IBDesignable //Allows class to render inside storyboard

class GradientView: UIView {

//    Makes storyboard update changes to colours etc
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
//        You can change the number of colours in the above array:
//        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor, topColor.cgColor] - will make a sandwich effect

        
//        Remember that top left is position (0,0) and bottom right is (1,1)!!!
//        For a left to right gradient, x will be 0.5 for both; for vertical, y will be 0.5 for both
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
