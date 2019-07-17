//
//  UserProfileControllerViewController.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 14/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit
import SDWebImage
class UserProfileControllerViewController: UIViewController {
    
    @IBOutlet weak var lblFollowersCount: UILabel!
    @IBOutlet weak var lblFollowingCount: UILabel!
    @IBOutlet weak var lblJoined: UILabel!
    @IBOutlet weak var lblIdNumber: UILabel!
    @IBOutlet weak var lblUpdated: UILabel!
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var lblUserBio: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnUserProfile: UIButton!
    
    @IBOutlet weak var lblLocationCity: UILabel!
    var strUserName: String?
    var startVal: Double = 0
    var endFollowVal: Double = 0
    var endFollowingVal: Double = 0
    let animattionDuration: Double = 1.5
    var animationStartDate = Date()
    private var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgProfilePicture.layer.borderWidth = 1
        imgProfilePicture.layer.masksToBounds = false
        imgProfilePicture.layer.borderColor = UIColor.black.cgColor
        imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.height/2
        imgProfilePicture.clipsToBounds = true
    }
    deinit {
        print("memory reclaimed no cycles")
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let name = strUserName else{
            print("error in name")
            return
        }
        getDataForUserProfile(strName: name)
    }
    
   fileprivate func getDataForUserProfile(strName: String) -> Void {
    let strUrl = API.UserDetails + strName
        NetWorkManagert.sharedNetWork.getDataFromUrl(url: strUrl, completion: { (result: UserProfile) in
            DispatchQueue.main.async {
                self.updateUserDetails(user: result)
            }
        }) { (err) in
            print("server error", err?.localizedDescription ?? "er")
        }
    }
    //MARK: Update UI Details
   fileprivate func updateUserDetails(user: UserProfile) -> Void {
        lblIdNumber.text = "Id:\(String(user.id ?? 0))"
    if user.name?.count == 0 || user.name == nil{
        lblUserName.text = user.login
    }else{
        lblUserName.text = user.name
    }
    
        endFollowVal = Double(user.followers ?? 0)
        endFollowingVal = Double(user.following ?? 0)
        animationStartDate = Date()
      let displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
      displayLink.add(to: .main, forMode: .default)
        self.displayLink = displayLink
        lblUserBio.text = user.bio
    lblLocationCity.text = user.location
        if let url = URL(string: user.avatar_url ?? "") {
            imgProfilePicture.sd_setImage(with: url) { (img, err, cahetype, url) in
            }
        }
        let obj = CommonFunctions()
        if let up = user.updated_at {
            let upDate = obj.convertDateFormater(strDT: up, givenFormat: "yyyy-MM-dd'T'HH:mm:ssZ", expectedFormat: "dd MMM yyyy")
            lblUpdated.text = upDate
        }
        if let cr = user.created_at{
            let crDate = obj.convertDateFormater(strDT: cr, givenFormat: "yyyy-MM-dd'T'HH:mm:ssZ", expectedFormat: "dd MMM yyyy")
             lblJoined.text = crDate
        }
    }
    @objc func handleAnimation() {
       let nowTime = Date()
        let elapsedTime = nowTime.timeIntervalSince(animationStartDate)
        if elapsedTime > animattionDuration{
            stopDisplayLink()
            lblFollowersCount.text = String(format: "%.f", endFollowVal)
            lblFollowingCount.text = String(format: "%.f", endFollowingVal)
        }else{
            let percent = elapsedTime / animattionDuration
            let val = String(format: "%.f",percent * (endFollowVal - startVal))
            let newval = String(format: "%.f",percent * (endFollowingVal - startVal))
            lblFollowersCount.text = "\(val)"
            lblFollowingCount.text = "\(newval)"
        }
    }
    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    @IBAction func btnUserProfileClicked(_ sender: Any) {
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

