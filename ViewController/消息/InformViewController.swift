//
//  InformViewController.swift
//  Live
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class InformViewController: UIViewController {

        var model: AgainModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()

        // Do any additional setup after loading the view.
    }

     
    @IBAction func myVideo(sender: UIButton) {

        let ac = UIAlertController.init(title: "即将开放此功能", message: "敬请期待哦！", preferredStyle: .Alert)
        let action = UIAlertAction.init(title: "好哒", style: UIAlertActionStyle.Cancel) { (action) in
        }
        ac.addAction(action)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    
    @IBAction func myLive(sender: UIButton) {
        let view = shoucangView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    
    

}
