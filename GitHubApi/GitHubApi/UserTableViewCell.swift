//
//  UserTableViewCell.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 15/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lblUserProName: UILabel!
    
    @IBOutlet weak var lblUserIdNumber: UILabel!
    
    @IBOutlet weak var lblUserScore: UILabel!
    
    @IBOutlet weak var btnUserFollower: UIButton!
    
    @IBOutlet weak var imgUserProfileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUserProfileImage.layer.borderWidth = 1
        imgUserProfileImage.layer.masksToBounds = false
        imgUserProfileImage.layer.borderColor = UIColor.black.cgColor
        imgUserProfileImage.layer.cornerRadius = imgUserProfileImage.frame.height/2
        imgUserProfileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
