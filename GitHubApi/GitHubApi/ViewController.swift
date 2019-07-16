//
//  ViewController.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 10/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnFollowers: UIButton!
    
    @IBOutlet weak var btnProfileClicked: UIButton!
    
    @IBOutlet weak var btnGetUserInformation: UIButton!
    
    @IBOutlet weak var txtUserSearch: UITextField!
    
    @IBOutlet weak var lblValidationMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserSearch.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
       lblValidationMessage.isHidden = true
    }
    //MARK: Button Click Events fetching Followers, Profile, Public Repo
    @IBAction func btnFollowersClicked(_ sender: Any) {
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "followercontroller") as? FollowerListController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnProfileClicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "userprofile") as? UserProfileControllerViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnUserInformationClicked(_ sender: Any) {
        if txtUserSearch.text?.count ?? 0 > 0{
            lblValidationMessage.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "userlistcontroller") as? UsersListController
            vc?.userName = txtUserSearch.text
            self.navigationController?.pushViewController(vc!, animated: true)
        } else{
            print("Enter user name")
            lblValidationMessage.isHidden = false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        lblValidationMessage.isHidden = true
        return false
    }
}

