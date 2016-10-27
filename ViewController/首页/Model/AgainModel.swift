//
//  AgainModel.swift
//  Live
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class AgainModel: NSObject {
    //昵称
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
}

extension AgainModel{
    
    class func requestAgainData(start: Int, callBack:(array: [AgainModel]?, error:NSError?)->Void){
        let urlStr = "http://appgw.yizhibo.tv/v2/topicvideolist?start=\(start)&live=1&count=20&device=ios&topicid=0&sessionid=GrIxgBIpJjY9qcqhBIc66rGuf9jyYgR3"
        
        BaseRequest.postWithURL(urlStr, para: nil) { (data, error) in
            if error == nil {
                 let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dict = obj["retinfo"] as! NSDictionary
                let arr = dict["videos"] as! NSArray
                var array = [AgainModel]()
                for d in arr{
                    let dic = d as! NSDictionary
                    let model = AgainModel()
                    model.location = dic["location"] as? String
                    model.logo_discover = dic["logo_discover"] as? String
                    model.logo_thumb = dic["logo_thumb"] as? String
                    model.nickname = dic["nickname"] as? String
                    model.play_url = dic["play_url"] as? String
                    model.title = dic["title"] as? String
                    model.watching_count = dic["watching_count"] as? Int
                    model.vid = dic["vid"] as? String
                    array.append(model)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array:array, error: nil)
                })
                
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: nil,error: error)
                })

            }
        }
    }

    class func requestData(start:Int, callBack:( array:[AgainModel]?, error: NSError?)->Void){
        let urlStr = "http://appgw.yizhibo.tv/v2/topicvideolist?start=\(start)&live=0&count=20&device=ios&topicid=0&sessionid=GrIxgBIpJjY9qcqhBIc66rGuf9jyYgR3"
        
        BaseRequest.postWithURL(urlStr, para: nil) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dict = obj["retinfo"] as! NSDictionary
                let arr = dict["videos"] as! NSArray
                var array = [AgainModel]()
                for d in arr{
                    let dic = d as! NSDictionary
                    let model = AgainModel()
                    model.location = dic["location"] as? String
                    model.logo_discover = dic["logo_discover"] as? String
                    model.logo_thumb = dic["logo_thumb"] as? String
                    model.nickname = dic["nickname"] as? String
                    model.play_url = dic["play_url"] as? String
                    model.title = dic["title"] as? String
                    model.watching_count = dic["watch_count"] as? Int
                    model.vid = dic["vid"] as? String
                    array.append(model)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: array, error: nil)
                })
                
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: nil,error: error)
                })
                
            }
        }
    }


}


