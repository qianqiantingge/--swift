//
//  data.swift
//  a38GaoQianPu
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class data:  NSObject , NSCoding{
    var nickname: String?
    //地名
    var location: String?
    //头像
    var logo_discover: String?
    //人数
    var watching_count: Int?
    //下面的标题
    var title: String?
    //中间的大图
    var logo_thumb: String?
    //直播地址
    var play_url: String?
    var vid: String?

    
    override init() {
        super.init()
    }
    
    //自定义的类型被归档时，系统自动调用的，对属性进行归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(nickname, forKey: "nickname")
        aCoder.encodeObject(location, forKey: "location")
        aCoder.encodeObject(logo_discover, forKey: "logo_discover")
        aCoder.encodeObject(watching_count, forKey: "watching_count")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(logo_thumb, forKey: "logo_thumb")
        aCoder.encodeObject(play_url, forKey: "play_url")
        aCoder.encodeObject(vid, forKey: "vid")
    }
    
    //解档的时候系统自动调用。对属性进行解档
    required init?(coder aDecoder: NSCoder) {
        //如果父类也遵守了NSCoding协议，需要加上父类的解档方法super.init(coder: aDecoder)
        nickname = aDecoder.decodeObjectForKey("nickname") as? String
        location = aDecoder.decodeObjectForKey("location") as? String
        logo_discover = aDecoder.decodeObjectForKey("logo_discover") as? String
        watching_count = aDecoder.decodeObjectForKey("watching_count") as? Int
        title = aDecoder.decodeObjectForKey("title") as? String
        logo_thumb = aDecoder.decodeObjectForKey("logo_thumb") as? String
        play_url = aDecoder.decodeObjectForKey("play_url") as? String
        vid = aDecoder.decodeObjectForKey("vid") as? String
    }

    
}
