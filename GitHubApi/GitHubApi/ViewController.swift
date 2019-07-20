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
    
    let followerLabel = UILabel()
    let UsersLabel = UILabel()
    let appInformation = UILabel()
    let imgFollowersLbl = UIImageView()
    let imgUserLbl = UIImageView()
    fileprivate func setUpLabels() {
       
        appInformation.numberOfLines = 0
        UsersLabel.numberOfLines = 0
        followerLabel.numberOfLines = 0
        appInformation.font = UIFont(name: "OpenSans-Semibold", size: 16)
        UsersLabel.font = UIFont(name: "OpenSans-Semibold", size: 16)
        followerLabel.font = UIFont(name: "OpenSans-Semibold", size: 16)
        appInformation.text = "Enter full user name or part of user name and click on 'Get User Information' to search all users releated to your inserted name."
        UsersLabel.text = "Search users or user on GitHub community. Know there score, followers count, following count."
        followerLabel.text = "Find the Followers of those Users."
    }
    
    fileprivate func setUpStackView() {
        let stackView = UIStackView (arrangedSubviews: [appInformation,UsersLabel,followerLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.frame = CGRect(x: btnGetUserInformation.frame.origin.x, y: (btnGetUserInformation.frame.origin.y + btnGetUserInformation.frame.size.height + 20), width: btnGetUserInformation.frame.size.width, height: 270.0)
        //Enable Auto Layout for Stack view by Programmatic Way
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserSearch.delegate = self
        
        //MARK : Created UI With Progrmatical Way
        setUpLabels()
        setUpStackView()
        setUpAnimation()
    }
    
    func setUpAnimation() -> Void {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
            self.appInformation.transform = CGAffineTransform(translationX: -100, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
                 self.appInformation.transform = self.appInformation.transform.translatedBy(x: 100, y: 0)
            })
            }
        
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
            self.UsersLabel.transform = CGAffineTransform(translationX: -100, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
                self.UsersLabel.transform = self.UsersLabel.transform.translatedBy(x: 100, y: 0)
            })
        }
        
        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
            self.followerLabel.transform = CGAffineTransform(translationX: -100, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
                self.followerLabel.transform = self.followerLabel.transform.translatedBy(x: 100, y: 0)
            })
        }
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
        setUpAnimation()
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

