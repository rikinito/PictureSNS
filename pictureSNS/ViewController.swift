//  ViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/06/19.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.


import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//                         データの送信
//                        let obj = NCMBObject(className: "lifeistech")
//                        obj.setObject("hello", forKey: "message")
//        
//                        var saveError: NSError?
//                        obj.save(&saveError)
//        
//                        if saveError == nil {
//                            print("[SAVE] Dome")
//                        } else {
//                            print("[SAVE-ERROR] /(saveError)")
//        
//        
//                        }
//        
        //         データの取得
        //        let query = NCMBQuery(className: "lifeistech")
        //        query.whereKey("message", equalTo: "hello")
        //        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) in
        //
        //            if let error = error {
        //                print("[ERROR] /(error)")
        //                return
        //            }
        //
        //            if objects.count > 0 {
        //
        //                // オヴジェクトが見つかった場合は表示
        //                if let obj = objects[0] as? NCMBObject {
        //                    let msg = obj.objectForKey("message")
        //                    print("[FINQ]:\(msg)")
        //                }
        //            } else {
        //                // 見つからなかた場合は新たに登録
        //                let obj = NCMBObject(className: "SNS")
        //                obj.setObject("Hello, NOMB!", forKey: "massage")
        //
        //                var saveError : NSError?
        //                obj.save(&saveError)
        //                if saveError == nil {
        //                    print("[SAVE] Dome")
        //
        //                } else {
        //                    print("[SAVE-ERROR] /(saveError)")
        //                }
        //            }
        //        }
        //
        
        
        
//               画像の送信
//                let imageData : NSData = NSData(data: UIImagePNGRepresentation(UIImage(named: "original.png")!)!)
//                let fileName = "lifeistech.png"
//                let file:NCMBFile = NCMBFile.fileWithName(fileName ,data: imageData) as!
//                    NCMBFile
//                let acl = NCMBACL()
//                //
//                acl.setPublicReadAccess(true)
//                acl.setPublicWriteAccess(true)
//                file.ACL = acl
//        
//                var error1 : NSError?
//                file.save(&error1)
//                if error1 != nil {
//                    print("Image data save error : ",error1)
//                }
//
//        
//                画像の取得
//                var image:UIImage? = nil
//                var imageData:NSData!
//        
//                let file:NCMBFile = NCMBFile.fileWithName("lifeistech.png" ,data: nil ) as!
//                    NCMBFile
//        
//                do {
//                    imageData = try file.getData()
//        
//                } catch let error1 as NSError {
//                   print("Image data read error : ",error1)
//                }
//                imageView.image = UIImage(data: imageData)
//        
//            }
    
        
        
        //        let query = NCMBFile.query()
        //
        //
        //        query.whereKey("fileName", containedIn: "画像")
        //        var fileArray : [NCMBFile]!
        //
        //        do {
        //            fileArray = try query.findObjects() as? [NCMBFile]
        //            guard let ar = fileArray else { return }
        //
        //            for file in ar {
        //
        //                // データを取得
        //                file.getDataInBackgroundWithBlock() { data, error in
        //                    if let error = error {
        //                        print("get error: \(error)")
        //
        //                    } else {
        //                        //let image = UIImage(data: data)
        //
        //                        print("get file.name: \(file.name)")
        //                    }
        //                }
        //            }
        //            print("read ok: \(fileArray?.count)")
        //        } catch {
        //            fileArray = nil
        //
        //            print("read error: \(error)")
        //        }
        //
        //
        
        //    override func didReceiveMemoryWarning() {
        //        super.didReceiveMemoryWarning()
        //        // Dispose of any resources that can be recreated.
        //    }
    }
//    
//    @IBAction func selectBackground() {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {    //追記
//            
//            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言しているという理解
//            let controller = UIImagePickerController()
//            
//            //おまじないという認識で今は良いと思う
//            controller.delegate = self
//            
//            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
//            //以下はカメラロールの例
//            //.Cameraを指定した場合はカメラを呼び出し(シミュレーター不可)
//            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            
//            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
//            self.present(controller, animated: true, completion: nil)
//        }
//    }
//    
//    // 写真選択時に呼ばれる
//    // 写真を選択した時に呼ばれる
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: Any]) {
//        
//        //このif条件はおまじないという認識で今は良いと思う
//        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
//            
//            //didFinishPickingMediaWithInfo通して渡された情報(選択された画像情報が入っている？)をUIImageにCastする
//            //そしてそれを宣言済みのimageViewへ放り込む
//            
//            let image: UIImage = (didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage]as? UIImage)!
//            
//            let size = CGSize(width: 150, height: 150)
//            UIGraphicsBeginImageContext(size)
//            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            //          画像の送信
//            let imageData : Data = NSData(data: UIImagePNGRepresentation(resizeImage!)!) as Data
//            
//            let date = Date() // Dec 27, 2015, 7:16 PM
//            
//            let format = DateFormatter()
//            format.dateFormat = "yyyy-MM-dd-HH-mm-ss"
//            
//            
//            let strDate = format.string(from: date)
//            let fileName = strDate+".png"
//            let file:NCMBFile = NCMBFile.file(withName: fileName ,data: imageData) as!
//            NCMBFile
//            let acl = NCMBACL()
//            //
//            acl.setPublicReadAccess(true)
//            acl.setPublicWriteAccess(true)
//            file.acl = acl
//            
//            var error1 : NSError?
//            file.save(&error1)
//            if error1 != nil {
//                print("Image data save error : ",error1)
//            }else {
//                print("success")
//            }
//            
//            
//            //            データの送信
//            let obj = NCMBObject(className: "lifeistech")
//            obj?.setObject(NCMBUser.current(), forKey: "UserName")
//            obj?.setObject(fileName,forKey: "FileName")
//            var saveError: NSError?
//            obj?.save(&saveError)
//            
//            if saveError == nil {
//                print("[SAVE] Dome")
//            } else {
//                print("[SAVE-ERROR] /(saveError)")
//                
//                
//            }
//            
//            
//            
//        }
//        
//        //写真選択後にカメラロール表示ViewControllerを引っ込める動作
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    @IBAction func getImage(_ sender: AnyObject) {
//        //                 データの取得
//        
//        
//        let query = NCMBQuery(className: "lifeistech")
//        query?.whereKey("UserName", equalTo: NCMBUser.name)
//        
//        query?.findObjectsInBackground({(objects, error) in
//            
//            if let error = error {
//            
//                print("[ERROR] /(error)")
//                return
//            }
//            
//            print( objects?.count)
//            
//            
//            if (objects?.count)! > 0 {
//                
//                for i in 0...(objects?.count)!-1 {
//                    
//                    // オヴジェクトが見つかった場合は表示
//                    if let obj = objects?[i] as? NCMBObject {
//                        let fileName = obj.object(forKey: "FileName")
//                        
//                        
//                        //        画像の取得
//                        var image:UIImage? = nil
//                        
//                        
//                        let file:NCMBFile = NCMBFile.file(withName: fileName as!
//                            String,data: nil ) as!
//                        NCMBFile
//                        var data : Data!
//                        
//                        do {
//                            data = try file.getData()
//                            
//                        } catch let error1 as NSError {
//                            print("Image data read error : ",error1)
//                        }
//                        
//                        var imageData = UIImage(data: data)
//                        print("取得完了")
//                        print(imageData!.size)
//                    }
//                    
//                }
//                
//                
//                
//            }
//        })
//        
//        
//      
//        
//        
//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
