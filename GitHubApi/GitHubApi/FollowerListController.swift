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
    var followerList =  [Any]()
    var followerUrl: String?
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
      /*  let jsonUrlString = "https://api.github.com/users/torvalds/followers"
        guard let url = URL(string: jsonUrlString) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else{
                return
            }
            //let jsonString = String(data: data, encoding: .utf8)
            do {
                let followers = try JSONDecoder().decode([UserFollower_New].self, from: data)
            for i in 0..<followers.count{
                let obj = followers[i] 
                print("LoginName: \(obj.login ?? "no") , ID: \(obj.id ?? -1)")
                }
            } catch let jsonerror{
                print(jsonerror)
            }
        }.resume()*/
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
        print("Error :\(error?.localizedDescription ?? "some error")")
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
