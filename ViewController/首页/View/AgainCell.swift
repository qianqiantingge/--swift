//
//  AgainCell.swift
//  Live
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class AgainCell: UITableViewCell {
    let path = NSHomeDirectory() + "/Documents/1"
    var model: AgainModel?
    
    var dataArr = [data]()
    
    @IBOutlet var see: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var dizhi: UILabel!
    @IBOutlet var hicon: UIImageView!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var num: UILabel!
    @IBOutlet var title: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func creatCell(){
        self.name.text = model?.nickname
        self.dizhi.text = model?.location
        self.hicon.sd_setImageWithURL(NSURL.init(string: (model?.logo_discover)!))
        self.icon.sd_setImageWithURL(NSURL.init(string: (model?.logo_thumb)!))
        self.num.text = "\(model!.watching_count!)"
        self.title.text = model?.title
        
    }

    @IBAction func shoucang(sender: UIButton) {
        let card = data()
        card.nickname = model?.nickname
        card.location = model?.location
        card.logo_discover = model?.logo_discover
        card.watching_count = model?.watching_count
        card.title = model?.title
        card.logo_thumb = model?.logo_thumb
        card.play_url = model?.play_url
        card.vid = model?.vid
        
//        let aCard = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [data]
        dataArr.append(card)
        _ = NSKeyedArchiver.archiveRootObject(dataArr, toFile: path)
    }
}
