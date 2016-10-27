//
//  ForesshowModel.swift
//  Live
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class ForesshowModel: NSObject {
    
    //节目名称
    var title: String?
    //大图片
    var thumb: String?
    //订阅人数
    var subscribe_count: Int?
    //地址
    var location: String?
    //头像
    var logourl: String?
    //名称
    var nickname: String?
    //时间
    var live_start_time: String?
    //内容
    var desc: String?
    
}

extension ForesshowModel{
    
    class func requestForesshowData(start: Int, callBack:(array: [ForesshowModel]?, error:NSError?)->Void){
        let urlStr = "http://appgw.yizhibo.tv/v2/livenoticelist?start=\(start)&gps_longitude=116.3639197701801&count=20&device=ios&gps_latitude=40.03619105831392&sessionid=GrIxgBIpJjY9qcqhBIc66rGuf9jyYgR3"
        
        BaseRequest.postWithURL(urlStr, para: nil) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dic = obj["retinfo"] as! NSDictionary
                let arr = dic["notices"] as! NSArray
                var array = [ForesshowModel]()
                for dict in arr{
                    let model = ForesshowModel()
                    model.title = (dict as! NSDictionary)["title"] as? String
                    model.thumb = (dict as! NSDictionary)["thumb"] as? String
                    model.subscribe_count = (dict as! NSDictionary)["subscribe_count"] as? Int
                    model.location = (dict as! NSDictionary)["location"] as? String
                    model.logourl = (dict as! NSDictionary)["logourl"] as? String
                    model.nickname = (dict as! NSDictionary)["nickname"] as? String
                    model.live_start_time = (dict as! NSDictionary)["live_start_time"] as? String
                    model.desc = (dict as! NSDictionary)["desc"] as? String
                    
                    array.append(model)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array:array , error: nil)
                })
                
                
            }else{
                    dispatch_async(dispatch_get_main_queue(), {
                        callBack(array: nil,error: error)
                    })
                }

                
                
            }
        }
    }

