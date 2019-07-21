//
//  FollowerListController.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 10/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit
import SDWebImage

class FollowerListController: UIViewController {
   
    @IBOutlet weak var tblFollowerList: UITableView!
    
    @IBOutlet weak var lblFollowersListName: UILabel!
    var followerList =  [Any]()
    var followerUrl: String?
    var strNameofFollowers: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFollowerList.dataSource = self
        tblFollowerList.delegate = self
        tblFollowerList.tableFooterView = UIView()
        self.navigationItem.title = "Followers"
    }
    
    deinit {
        print("Reclaim memory in followers")
    }
    
   override func viewDidAppear(_ animated: Bool) {
    if let usern = strNameofFollowers{
        lblFollowersListName.text = "User \(usern)'s followers"
    }else{
        lblFollowersListName.text = ""
    }
    
    guard let urlNew = followerUrl else{
        print("No valid Url")
        return
    }
    getDataForFollowers(followUrl: urlNew)
}
   fileprivate func getDataForFollowers(followUrl: String){
    NetWorkManagert.sharedNetWork.getDataFromUrl(url: followUrl, completion: { (result: [UserFollower_New]) in
        self.followerList = result
        DispatchQueue.main.async {
            self.tblFollowerList.reloadData()
        }
    }, error: { (error) in
        DispatchQueue.main.async{
            let alert = UIAlertController(title: "GitHub", message: error?.localizedDescription ?? "Something went wrong.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
                switch action.style{
                case .default:
                    guard let urlNew = self.followerUrl else{
                        print("No valid Url")
                        return
                    }
                    self.getDataForFollowers(followUrl: urlNew)
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
       // print("Error :\(error?.localizedDescription ?? "some error")")
    })
    }
    
}

extension FollowerListController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "followercell", for: indexPath) as! FollowerInfoTableViewCell
        let objList = followerList[indexPath.row] as? UserFollower_New
        cell.lblUserName.text = objList?.login
        cell.lblId.text = String(objList?.id ?? -1)
        cell.btnProfileUrl.setTitle(objList?.html_url, for: UIControl.State.normal)
        if let url = URL(string: objList?.avatar_url ?? "") {
            cell.imgUser.sd_setImage(with: url) { (img, err, cahetype, url) in
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 128.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        var cellFrame = cell.contentView.frame
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
            cellFrame.origin.x = UIScreen.main.bounds.size.width
            cell.contentView.frame = cellFrame
        }) { (success) in
            cellFrame.origin.x = 0
            cell.contentView.frame = cellFrame
        }
    }
}
