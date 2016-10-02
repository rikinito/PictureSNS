//
//  TimeLineViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/10/02.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var imagiView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = NCMBQuery(className: "lifeistech")
        query.whereKey("UserName", equalTo: NCMBUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) in
            
            if let error = error {
                print("[ERROR] /(error)")
                return
            }
            
            print( objects.count)
            
            
            if objects.count > 0 {
                
                for i in 0...objects.count-1 {
                    
                    // オヴジェクトが見つかった場合は表示
                    if let obj = objects[i] as? NCMBObject {
                        let fileName = obj.objectForKey("FileName")
                        
                        
                        //        画像の取得
                        var image:UIImage? = nil
                        
                        
                        let file:NCMBFile = NCMBFile.fileWithName(fileName as!
                            String,data: nil ) as!
                        NCMBFile
                        var data : NSData!
                        
                        do {
                            data = try file.getData()
                            
                        } catch let error1 as NSError {
                            print("Image data read error : ",error1)
                        }
                        
                        var imageData = UIImage(data: data)
                        self.imagiView.image = imageData
                        
                        print(imageData!.size)
                    }
                    
                }
                
                
                
            }
        }
        
        
        

    }
    
    @IBAction func sendImage(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {    //追記
            
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言しているという理解
            let controller = UIImagePickerController()
            
            //おまじないという認識で今は良いと思う
            controller.delegate = self
            
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            //以下はカメラロールの例
            //.Cameraを指定した場合はカメラを呼び出し(シミュレーター不可)
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.presentViewController(controller, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: AnyObject]) {
        
        //このif条件はおまじないという認識で今は良いと思う
        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
            
            //didFinishPickingMediaWithInfo通して渡された情報(選択された画像情報が入っている？)をUIImageにCastする
            //そしてそれを宣言済みのimageViewへ放り込む
            
            let image: UIImage = (didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage]as? UIImage)!
            imagiView.image = image
            
            let size = CGSize(width: 150, height: 150)
            UIGraphicsBeginImageContext(size)
            image.drawInRect(CGRectMake(0, 0, size.width, size.height))
            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //          画像の送信
            let imageData : NSData = NSData(data: UIImagePNGRepresentation(resizeImage)!)
            
            let date = NSDate() // Dec 27, 2015, 7:16 PM
            
            let format = NSDateFormatter()
            format.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            
            
            let strDate = format.stringFromDate(date)
            let fileName = strDate+".png"
            let file:NCMBFile = NCMBFile.fileWithName(fileName ,data: imageData) as!
            NCMBFile
            let acl = NCMBACL()
            //
            acl.setPublicReadAccess(true)
            acl.setPublicWriteAccess(true)
            file.ACL = acl
            
            var error1 : NSError?
            file.save(&error1)
            if error1 != nil {
                print("Image data save error : ",error1)
            }else {
                print("success")
            }
            
            
            //            データの送信
            let obj = NCMBObject(className: "lifeistech")
            obj.setObject(NCMBUser.currentUser(), forKey: "UserName")
            obj.setObject(fileName,forKey: "FileName")
            var saveError: NSError?
            obj.save(&saveError)
            
            if saveError == nil {
                print("[SAVE] Dome")
            } else {
                print("[SAVE-ERROR] /(saveError)")
                
                
            }
            
            
            
        }
        
        //写真選択後にカメラロール表示ViewControllerを引っ込める動作
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}