//
//  DesignableButton.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 20/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {

    @IBInspectable var borderWidth : CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var bgColour : UIColor = .clear{
        didSet{
            self.layer.borderColor = bgColour.cgColor
        }
    }
    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
