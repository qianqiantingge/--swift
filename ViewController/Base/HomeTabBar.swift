//
//  HomeTabBar.swift
//  Live
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class HomeTabBar: UITabBarController {
    
    var lastBtn: UIButton?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createVC()
        self.creatBar()
        
    }
    

    
    
    func createVC() {
        let firstView = FirstViewController()
        let fineView = FindViewController()
        let firendView = FirendViewController()
        let informView = InformViewController()
        
        let firstNav = UINavigationController.init(rootViewController: firstView)
        let findNav = UINavigationController.init(rootViewController: fineView)
        let firendNav = UINavigationController.init(rootViewController: firendView)
        let informNav = UINavigationController.init(rootViewController: informView)
        
        firstNav.navigationBar.barTintColor = UIColor.redColor()
        findNav.navigationBar.barTintColor = UIColor.redColor()
        firendNav.navigationBar.barTintColor = UIColor.redColor()
        informNav.navigationBar.barTintColor = UIColor.redColor()
        
        self.viewControllers = [firstNav, findNav,UIViewController(), firendNav, informNav]
    }
    
    func creatBar(){
        //导航条
        let barView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: TABBAR_H))
        barView.backgroundColor = UIColor.redColor()
        self.tabBar.addSubview(barView)
        let titleArr = ["首页", "发现","", "朋友", "消息"]
        for i in 0...4 {
            if i == 2 {
                continue
            }
            //(((SCREEN_W / 5 - 30) / 2) + i * Int(SCREEN_W) / 5)
            let btn = UIButton.init(type: UIButtonType.Custom)
            let xx = (SCREEN_W / 5 - 30) / 2 + CGFloat(i) * (SCREEN_W) / 5
            btn.frame = CGRect.init(x: xx, y: 5, width: 30, height: 30)
            btn.setBackgroundImage(UIImage.init(named: titleArr[i] + "a"), forState: .Normal)
            btn.setBackgroundImage(UIImage.init(named: String.init(format: titleArr[i] + "b", i)), forState: .Selected)
    
            barView.addSubview(btn)
            btn.tag = i + 100
            btn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: .TouchUpInside)
            
            let label = UILabel.init(frame: CGRectMake(-10, 30, 50, 14))
            label.font = UIFont.systemFontOfSize(10)
            label.text = titleArr[i]
            label.textColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
           
            label.textAlignment = .Center
            btn.addSubview(label)
            
            label.tag = i + 1000
            
            if i == 0 {
                btn.selected = true
                label.textColor = UIColor.orangeColor()
                lastBtn = btn
            }

        }
    
    }
    
    func btnClick(sender: UIButton){
        if lastBtn == sender {
            return
        }
        
        
        
        lastBtn?.selected = false
        let label = lastBtn?.subviews.last as! UILabel
        label.textColor = UIColor.darkGrayColor()
        
        sender.selected = true
        let currentLabel = sender.subviews.last as! UILabel
        currentLabel.textColor = UIColor.orangeColor()
        
        lastBtn = sender
        self.selectedIndex = sender.tag - 100
    }


}
