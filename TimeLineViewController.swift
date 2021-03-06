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
//        self.table.delegate = self
//    
//    
//        let query = NCMBQuery(className: "lifeistech")
//        query?.whereKey("UserName", equalTo: NCMBUser.current())
//        
//        
//        query?.findObjectsInBackground({(objects, error) in
//            
//            if let error = error {
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
//                        
//                        
//                        
//                        self.images.append(UIImage(data: data)!)
//                        
//                    }
//                    
//                }
//                
//                self.table.reloadData()
//                
//                
//                
//            }
//        })
        
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
            return cell
        
    }
    
    @IBAction func sendImage(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {    //追記
            
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言しているという理解
            let controller = UIImagePickerController()
            
            //おまじないという認識で今は良いと思う
            controller.delegate = self
            
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            //以下はカメラロールの例
            //.Cameraを指定した場合はカメラを呼び出し(シミュレーター不可)
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(controller, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: Any]) {
        
        //このif条件はおまじないという認識で今は良いと思う
        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
            
            //didFinishPickingMediaWithInfo通して渡された情報(選択された画像情報が入っている？)をUIImageにCastする
            //そしてそれを宣言済みのimageViewへ放り込む
            
            let image: UIImage = (didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage]as? UIImage)!
            
            let size = CGSize(width: 150, height: 150)
            UIGraphicsBeginImageContext(size)
            image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //          画像の送信
            let imageData : Data = NSData(data: UIImagePNGRepresentation(resizeImage!)!) as Data
            
            let date = Date() // Dec 27, 2015, 7:16 PM
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            
            
            let strDate = format.string(from: date)
            let fileName = strDate+".png"
            let file:NCMBFile = NCMBFile.file(withName: fileName ,data: imageData) as!
            NCMBFile
            let acl = NCMBACL()
            //
            acl.setPublicReadAccess(true)
            acl.setPublicWriteAccess(true)
            file.acl = acl
            
            var error1 : NSError?
            file.save(&error1)
            if error1 != nil {
                print("Image data save error : ",error1)
            }else {
                print("success")
            }
            
            
            //            データの送信
            let obj = NCMBObject(className: "lifeistech")
            obj?.setObject(NCMBUser.current(), forKey: "UserName")
            obj?.setObject(fileName,forKey: "FileName")
            var saveError: NSError?
            obj?.save(&saveError)
            
            if saveError == nil {
                print("[SAVE] Dome")
            } else {
                print("[SAVE-ERROR] /(saveError)")
                
                
            }
            
            
            
        }
        
        //写真選択後にカメラロール表示ViewControllerを引っ込める動作
        picker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func getImage(_ sender: AnyObject) {
        //                 データの取得
        
        
        let query = NCMBQuery(className: "lifeistech")
        query?.whereKey("UserName", equalTo: NCMBUser.save)
        
        query?.findObjectsInBackground({(objects, error) in
            
            if let error = error {
                
                print("[ERROR] /(error)")
                return
            }
            
            print( objects?.count)
            
            
            if (objects?.count)! > 0 {
                
                for i in 0...(objects?.count)!-1 {
                    
                    // オヴジェクトが見つかった場合は表示
                    if let obj = objects?[i] as? NCMBObject {
                        let fileName = obj.object(forKey: "FileName")
                        
                        
                        //        画像の取得
                        var image:UIImage? = nil
                        
                        
                        let file:NCMBFile = NCMBFile.file(withName: fileName as!
                            String,data: nil ) as!
                        NCMBFile
                        var data : Data!
                        
                        do {
                            data = try file.getData()
                            
                        } catch let error1 as NSError {
                            print("Image data read error : ",error1)
                        }
                        
                        var imageData = UIImage(data: data)
                        print("取得完了")
                        print(imageData!.size)
                    }
                    
                }
                
                
                
            }
        })
        
        
        
        
        
    }

    
    
    
    
    @IBDesignable class CustomButton: UIButton {
        
        // 角丸の半径(0で四角形)
        @IBInspectable var cornerRadius: CGFloat = 0.0
        
        // 枠
        @IBInspectable var borderColor: UIColor = UIColor.clear
        @IBInspectable var borderWidth: CGFloat = 0.0
        
        override func draw(_ rect: CGRect) {
            // 角丸
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = (cornerRadius > 0)
            
            // 枠線
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
            
            super.draw(rect)
        }
    }

}
