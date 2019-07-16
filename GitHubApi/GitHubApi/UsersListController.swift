//
//  UsersListController.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 15/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit

class UsersListController: UIViewController {
    
    @IBOutlet weak var lblSearchUserList: UILabel!
    
    @IBOutlet weak var tblUserList: UITableView!
    
    var userList = [Any]()
    var userName: String?
    var pageCount: Int = 1
    var totalPageCount:Int = 0
    var totalRecords: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tblUserList.dataSource = self
        tblUserList.delegate = self
        tblUserList.tableFooterView = UIView()
        self.navigationItem.title = "Users List"
    }
    deinit {
        print("no leak")
    }
    override func viewDidAppear(_ animated: Bool) {
        getDataForUserFollowersee(name: userName!, pageNo: pageCount)
    }
    
   fileprivate func getDataForUserFollowersee(name: String, pageNo: Int) -> Void {
        let urlStr = API.followerList + "\(name)&page=\(pageNo)"
        NetWorkManagert.sharedNetWork.getDataFromUrl(url: urlStr, completion: { (result: UserFollowersInfo) in
            if let newCount = result.total_count{
                self.totalRecords = newCount
                self.totalPageCount = newCount / 30
                if (newCount % 30) > 0{
                    self.totalPageCount  += 1
                }
            }
            if let news = result.items{
                if self.userList.count > 0{
                    self.userList.append(contentsOf: news)
                }else{
                   self.userList = news
                }
                DispatchQueue.main.async {
                    self.lblSearchUserList.text = "Total: \(result.total_count ?? 0) results Found"
                    self.tblUserList.reloadData()
                }
            }
        }, error: { (error) in
            //print("Error \(error?.localizedDescription ?? "Something went wrong.")")
        })
    }
}

extension UsersListController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usercell", for: indexPath) as! UserTableViewCell
        let objList = userList[indexPath.row] as? SingleFollowerInfo
        cell.lblUserProName.text = objList?.login
        cell.lblUserIdNumber.text = "Id: \(String(objList?.id ?? 0))"
        cell.lblUserScore.text = "Score: \(String(objList?.score ?? 0))"
        if let url = URL(string: objList?.avatar_url ?? "") {
            cell.imgUserProfileImage.sd_setImage(with: url) { (img, err, cahetype, url) in
            }
        }
        
       cell.btnUserFollower.addTarget(self, action:#selector(btnFollowersClciked), for: .touchUpInside)
        cell.btnUserFollower.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 146.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row == userList.count - 1{
            if userList.count < totalRecords{
                if pageCount < self.totalPageCount{
                    pageCount =  pageCount + 1
                     getDataForUserFollowersee(name: userName!, pageNo: pageCount)
                }
            }
        }
    }
    @objc func btnFollowersClciked(sender: UIButton!){
        let objList = userList[sender.tag] as? SingleFollowerInfo
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "followercontroller") as? FollowerListController
        vc?.followerUrl = objList?.followers_url
        self.navigationController?.pushViewController(vc!, animated: true)
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        if offsetY > contentHeight - scrollView.frame.height{
//            print("Batch fetch")
//        }
//    }
    
}
