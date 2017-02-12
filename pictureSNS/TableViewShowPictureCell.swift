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
    
    
    var objctId : String = ""
    
  
   
    
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
    }
}
