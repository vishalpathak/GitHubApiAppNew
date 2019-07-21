//
//  CommonFunctions.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 14/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit
import Foundation

class CommonFunctions: NSObject {
    //MARK: Convert Date format
    func convertDateFormater(strDT: String, givenFormat: String, expectedFormat: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        let date = dateFormatter.date(from: strDT)
        dateFormatter.dateFormat = expectedFormat
        return  dateFormatter.string(from: date!)
    }
    //MARK: Show ALert message.
    public func ShowAlert(title: String, message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
}

