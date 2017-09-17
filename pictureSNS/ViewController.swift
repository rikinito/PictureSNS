//  ViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/06/19.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.


import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var LoginBuuton: UIButton!
    
    
    @IBOutlet weak var SignUpBuuton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpBuuton.backgroundColor = UIColor.blue // 背景色
        SignUpBuuton.layer.borderWidth = 2.0 // 枠線の幅
        SignUpBuuton.layer.borderColor = UIColor.blue.cgColor // 枠線の色
        SignUpBuuton.layer.cornerRadius = 10.0 // 角丸のサイズ
        SignUpBuuton.setTitleColor(UIColor.white,for: UIControlState.normal) // タイトルの色
        
        LoginBuuton.backgroundColor = UIColor.blue // 背景色
        LoginBuuton.layer.borderWidth = 2.0 // 枠線の幅
        LoginBuuton.layer.borderColor = UIColor.blue.cgColor // 枠線の色
        LoginBuuton.layer.cornerRadius = 10.0 // 角丸のサイズ
        LoginBuuton.setTitleColor(UIColor.white,for: UIControlState.normal) // タイトルの色
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
