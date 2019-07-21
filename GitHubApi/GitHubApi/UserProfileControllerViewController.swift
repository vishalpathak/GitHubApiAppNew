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
    
    @IBOutlet weak var lblLocationCity: UILabel!
    
    @IBOutlet weak var lblPublicRepos: UILabel!
    
    @IBOutlet weak var lblPublicGists: UILabel!
    
    var strUserName: String?
    var startVal: Double = 0
    var endFollowVal: Double = 0
    var endFollowingVal: Double = 0
    var reposCount: Double = 0
    var gistsCount: Double = 0
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
        self.navigationItem.title = "Profile"
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
            DispatchQueue.main.async{
                let alert = UIAlertController(title: "GitHub", message: err?.localizedDescription ?? "Something went wrong.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        guard let name = self.strUserName else{
                            return
                        }
                        self.getDataForUserProfile(strName: name)
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destruct")
                    }}))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destruct")
                    }}))
                
                self.present(alert, animated: true, completion: nil)
            }
            //print("server error", err?.localizedDescription ?? "er")
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
        reposCount = Double(user.public_repos ?? 0)
        gistsCount = Double(user.public_gists ?? 0)
        animationStartDate = Date()
      let displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
      displayLink.add(to: .main, forMode: .default)
        self.displayLink = displayLink
    lblUserBio.text = "\(user.bio ?? "Bio:")"
    lblLocationCity.text = "\(user.location ?? "Location:")"
        if let url = URL(string: user.avatar_url ?? "") {
            imgProfilePicture.sd_setImage(with: url) { (img, err, cahetype, url) in
            }
        }
        let obj = CommonFunctions()
        if let up = user.updated_at {
            let upDate = obj.convertDateFormater(strDT: up, givenFormat: "yyyy-MM-dd'T'HH:mm:ssZ", expectedFormat: "dd MMM yyyy, HH:mm")
            lblUpdated.text = upDate
        }
        if let cr = user.created_at{
            let crDate = obj.convertDateFormater(strDT: cr, givenFormat: "yyyy-MM-dd'T'HH:mm:ssZ", expectedFormat: "dd MMM yyyy, HH:mm")
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
            lblPublicRepos.text = String(format: "%.f", reposCount)
            lblPublicGists.text = String(format: "%.f", gistsCount)
        }else{
            let percent = elapsedTime / animattionDuration
            let val = String(format: "%.f",percent * (endFollowVal - startVal))
            let newval = String(format: "%.f",percent * (endFollowingVal - startVal))
            let repos = String(format: "%.f",percent * (reposCount - startVal))
            let gists = String(format: "%.f",percent * (gistsCount - startVal))
            lblFollowersCount.text = "\(val)"
            lblFollowingCount.text = "\(newval)"
            lblPublicRepos.text = "\(repos)"
            lblPublicGists.text = "\(gists)"
        }
    }
    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }

}

