//
//  ForeshowCell.swift
//  Live
//
//  Created by qianfeng on 16/10/23.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class ForeshowCell: UITableViewCell {
    
    var model: ForesshowModel?
    
    //头像
    @IBOutlet var headV: UIImageView!
    //名字
    @IBOutlet var name: UILabel!
    //地址
    @IBOutlet var dihzi: UILabel!
    //大图片
    @IBOutlet var imageV: UIImageView!
    //订阅人数
    @IBOutlet var Num: UILabel!
    //节目名称
    @IBOutlet var tutle: UILabel!
    //预约时间
    @IBOutlet var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headV.layer.masksToBounds = true
        self.headV.layer.cornerRadius = 25


        
        
        // Initialization code
//        self.creatCell()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func creatCell(){
        self.headV.sd_setImageWithURL(NSURL.init(string: model!.logourl!))
        self.name.text = model?.nickname
        self.dihzi.text = model!.location
        self.imageV.sd_setImageWithURL(NSURL.init(string: model!.thumb!))
        self.Num.text = "订阅人数：" + "\(model!.subscribe_count!)"
        self.tutle.text = model?.title
        self.time.text = "开播时间" + model!.live_start_time!
    }
    
}
