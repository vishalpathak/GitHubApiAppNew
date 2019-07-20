//
//  Constants.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 11/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import Foundation
struct API {
    static let BASE_URL : String = "https://api.github.com/"
    static let UserDetails : String = BASE_URL + "users/"
    static let followerList: String = BASE_URL + "search/users?q="
}
