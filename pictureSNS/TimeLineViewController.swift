//
//  TimeLineViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/10/02.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var images : [UIImage] = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        
        
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
                        
                        
                        
                        let file:NCMBFile = NCMBFile.fileWithName(fileName as!
                            String,data: nil ) as!
                        NCMBFile
                        var data : NSData!
                        
                        do {
                            data = try file.getData()
                            
                        } catch let error1 as NSError {
                            print("Image data read error : ",error1)
                        }
                        
                        
                        
                        
                     self.images.append(UIImage(data: data)!)
                      
                    }
                    
                }
                
                self.table.reloadData()
                
                
                
            }
            
            

        }
        
        
        

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomTableViewCell
            
            cell.name.text = "ああああああ"
            return cell
        
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

    
    
    
    
    
    
    @IBDesignable class CustomButton: UIButton {
        
        // 角丸の半径(0で四角形)
        @IBInspectable var cornerRadius: CGFloat = 0.0
        
        // 枠
        @IBInspectable var borderColor: UIColor = UIColor.clearColor()
        @IBInspectable var borderWidth: CGFloat = 0.0
        
        override func drawRect(rect: CGRect) {
            // 角丸
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = (cornerRadius > 0)
            
            // 枠線
            self.layer.borderColor = borderColor.CGColor
            self.layer.borderWidth = borderWidth
            
            super.drawRect(rect)
        }
    }

}