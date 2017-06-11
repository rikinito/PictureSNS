//
//  TimeLineShowViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/11/06.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//
import UIKit

class TimeLineShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var images : [UIImage] = [UIImage]()
    var texts : [String] = [String]()
    var Ids : [String] = [String]()
    var comentsArray : [[String]] = [[String]]()
    var likenumbers : [Int] = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.table.rowHeight = 250
        self.table.register(UINib(nibName: "TableViewShowPictureCell", bundle: nil), forCellReuseIdentifier: "PictureCell")
        
        
       self.table.rowHeight = 600
    
        
        
        reload()
        
        
        
    }
    
    @IBAction func reload() {
        let query = NCMBQuery(className: "lifeistech")
        query?.whereKey("UserName", equalTo: NCMBUser.current())
        
        
        query?.findObjectsInBackground({(objects, error) in
            
            if let error = error {
                print("[ERROR] /(error)")
                return
            }
            
            print( objects?.count)
            
            
            if (objects?.count)! > 0 {
                
                self.images.removeAll()
                self.texts.removeAll()
                self.comentsArray.removeAll()
                self.likenumbers.removeAll()
                self.Ids.removeAll()

                
                for i in 0...(objects?.count)!-1 {
                                        
                    // オヴジェクトが見つかった場合は表示
                    if let obj = objects?[i] as? NCMBObject {
                        
                        let id = obj.objectId
                        print(id)
                        self.Ids.append(id!)
                        
                        
                        let text = obj.object(forKey: "Expression")
                        self.texts.append(text as! String)
                        
                        
                        let coments = obj.object(forKey: "coments")
                        
                        self.comentsArray.append((coments as? [String])!)
                        
                        let likenumber = obj.object(forKey: "likeNumber")
                        print(likenumber)

                        self.likenumbers.append((likenumber as? Int)!)
               


                        print(text)
                        
                        
                        let fileName = obj.object(forKey: "FileName")
                        let file:NCMBFile = NCMBFile.file(withName: fileName as!
                            String,data: nil ) as! NCMBFile
                        var data : Data!
                        
                        do {
                            data = try file.getData()
                            
                        } catch let error1 as NSError {
                            print("Image data read error : ",error1)
                        }
                        
                        
                
                        
                        self.images.append(UIImage(data: data)!)
                        print(UIImage(data: data)!.size)
                        
                    }
                    
                }
                self.table.reloadData()
                
                
                
            }
        })
        
        self.table.delegate = self
        self.table.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell : TableViewShowPictureCell = table.dequeueReusableCell(withIdentifier: "PictureCell",for: indexPath) as! TableViewShowPictureCell
            
          
            let re = CGRect(x:0,y:0,width:table.frame.width,height:table.frame.width)
            UIGraphicsBeginImageContext(re.size)
            images[indexPath.row].draw(in: re)
            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            //cell.imageView?.image = resizeImage
            
            print(images.count)
            print(Ids.count)
            
            cell.imageView?.image = images[indexPath.row]
            
            
            //cell.imageView?.frame = CGRect(x:0,y:0,width:table.frame.width-50,height:table.frame.width)
            cell.objctId = Ids[indexPath.row]
            
            cell.comment.text = texts[indexPath.row]
            cell.likeNumber.text = String(likenumbers[indexPath.row])
            
            print(cell.frame)
            print(cell.imageView?.frame)
            print(cell.imageView?.image?.size)
          
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
        
        print("@@@")
        
        //このif条件はおまじないという認識で今は良いと思う
        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
            
            let image: UIImage = (didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage]as? UIImage)!
            
            SendDataViewController.imageData = image
            
            
            //写真選択後にカメラロール表示ViewControllerを引っ込める動作
            picker.dismiss(animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "GoToSendDataContlloer", sender: nil)
            
           
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
    
}
