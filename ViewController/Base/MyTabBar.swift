//
//  MyTabBar.swift
//  Live
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class MyTabBar: UITabBarController {

    
    func createVC() {
        let firstView = FirstViewController()
        let fineView = FindViewController()
//        let firendView = FirendViewController()
//        let informView = InformViewController()
        let storyboard = UIStoryboard.init(name: "informStoryboard", bundle: nil)
        let view = storyboard.instantiateViewControllerWithIdentifier("info")
        
        
        
        let firstNav = UINavigationController.init(rootViewController: firstView)
        let findNav = UINavigationController.init(rootViewController: fineView)
//        let firendNav = UINavigationController.init(rootViewController: firendView)
        let informNav = UINavigationController.init(rootViewController: view)
        
        firstNav.navigationBar.barTintColor = UIColor.redColor()
        findNav.navigationBar.barTintColor = UIColor.redColor()
//        firendNav.navigationBar.barTintColor = UIColor.redColor()
        informNav.navigationBar.barTintColor = UIColor.redColor()
        
        firstNav.tabBarItem = UITabBarItem.init(title: "首页", image: UIImage.init(named: "首页"), tag: 0)
        findNav.tabBarItem = UITabBarItem.init(title: "同城", image: UIImage.init(named: "同城"), tag: 1)
        informNav.tabBarItem = UITabBarItem.init(title: "设置", image: UIImage.init(named: "设置"), tag: 2)
        self.viewControllers = [firstNav, findNav, informNav]
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createVC()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
