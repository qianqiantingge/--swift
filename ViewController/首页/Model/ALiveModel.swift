//
//  ALiveModel.swift
//  Live
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class ALiveModel: NSObject {
    var play_url: String?
}

extension ALiveModel{
    class func requestALiveData(urlStr: String, callBack:(url: String?, error: NSError?)->Void){
            
            BaseRequest.postWithURL(urlStr, para: nil) { (data, error) in
                if error == nil {
                    let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let dict = obj["retinfo"] as! NSDictionary
                    let url = dict["play_url"] as! String
                
                    dispatch_async(dispatch_get_main_queue(), {
                        callBack(url: url, error: nil)
                    })
                }else{
                    dispatch_async(dispatch_get_main_queue(), {
                        callBack(url: nil,error: error)
                    })
                }
            }
    }
}
