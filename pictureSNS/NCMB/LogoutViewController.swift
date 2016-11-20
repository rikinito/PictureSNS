//
//  LogoutViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/09/18.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {

    @IBAction func logout() {
        NCMBUser.logOut()
        
   }
}
