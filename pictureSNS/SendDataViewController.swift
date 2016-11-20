//
//  SendDataViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/11/20.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit

class SendDataViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    static var imageData : UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = SendDataViewController.imageData
            
    }
  }
