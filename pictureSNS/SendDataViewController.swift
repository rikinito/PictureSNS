//
//  SendDataViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/11/20.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit

class SendDataViewController: UIViewController{
    
    @IBOutlet weak var sendTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    static var imageData : UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = SendDataViewController.imageData
        
    }
    @IBAction func send(_ sender: Any) {
        
        
        
        // リサイズ
        let re = CGRect(x: 0, y: 0, width: 300, height: 300)
        UIGraphicsBeginImageContext(re.size)
        SendDataViewController.imageData.draw(in: re)
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let date = Date() // Dec 27, 2015, 7:16 PM
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        
        
        let strDate = format.string(from: date)
        let fileName = strDate+".png"
        let file:NCMBFile = NCMBFile.file(withName: fileName ,data: UIImagePNGRepresentation(resizeImage!)! as Data ) as!
        NCMBFile
        let acl = NCMBACL()
        //
        acl.setPublicReadAccess(true)
        acl.setPublicWriteAccess(true)
        file.acl = acl
        
        var error1 : NSError?
        file.save(&error1)
        if error1 != nil {
            print(error1?.localizedDescription)

        }else {
            print("success")
        }
        
        
        //            データの送信
        let obj = NCMBObject(className: "lifeistech")
        obj?.setObject(NCMBUser.current(), forKey: "UserName")
        obj?.setObject(fileName,forKey: "FileName")
        obj?.setObject(0,forKey: "likeNumber")
        obj?.setObject([], forKey: "coments")
        
        let text = sendTextView.text
        obj?.setObject(text,forKey: "Expression")
        
        
        var saveError: NSError?
        obj?.save(&saveError)
        
        if saveError == nil {
            print("[SAVE] Dome")
        } else {
            print("[SAVE-ERROR] /(saveError)")
            
            
        }
        
    
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("タッチ")
        if (self.sendTextView.isFirstResponder) {
            self.sendTextView.resignFirstResponder()
            
        }else if(self.sendTextView.isFirstResponder) {
            self.sendTextView.resignFirstResponder()
        }
        
        
    }

}
