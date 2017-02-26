//
//  TableViewShowPictureCell.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/11/06.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit

class TableViewShowPictureCell: UITableViewCell {
    
    @IBOutlet weak var UserIcon: UIImageView!
    
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var comment: UILabel!
    
    @IBOutlet weak var iineButton: UIButton!
    
    @IBOutlet weak var likeNumber: UILabel!
  
    
    var objctId : String = ""
    
    let obj = NCMBObject(className: "lifeistech")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initalization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for selected state
    }
    @IBAction func iine(_ sender: Any) {
        
        
        
        print("いいね！")
        print(objctId)
        
        
        obj?.objectId = objctId
        
        
        
        obj?.fetchInBackground { (error) in
            if error != nil {
                // 取得に失敗した場合の処理
                print(error)
            }else{
                
                print("@@@")
                // 取得に成功した場合の処理
                self.obj?.incrementKey("likeNumber")
                self.obj?.saveInBackground { (error) in
                    if error != nil {
                        print(error)
                    }else{
                        
                    }
                }
                
            }
        }
        
    }
}
