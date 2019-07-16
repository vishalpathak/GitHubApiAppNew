//
//  FollowerInfoTableViewCell.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 11/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit

class FollowerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblId: UILabel!
    
    @IBOutlet weak var btnProfileUrl: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.layer.borderWidth = 1
        imgUser.layer.masksToBounds = false
        imgUser.layer.borderColor = UIColor.black.cgColor
        imgUser.layer.cornerRadius = imgUser.frame.height/2
        imgUser.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
