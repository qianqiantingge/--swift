//
//  shoucangView.swift
//  Live
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class shoucangView: UIViewController {
    
//    var nav: UINavigationController?
    let path = NSHomeDirectory() + "/Documents/1"
    var dataArr = [data]()
    let card = AgainModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jiedang()
        
        let tableView = UITableView.init(frame: CGRectMake(0, 44, SCREEN_W, SCREEN_H - 44 - 49), style: UITableViewStyle.Plain)
        tableView.registerNib(UINib.init(nibName: "AgainCell", bundle: nil), forCellReuseIdentifier: "AgainCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    
    
    }
    
    func jiedang(){
        
        let da =  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [data]
        if da != nil{
            dataArr = da!
        }
    }
    
    func jieModel(model:data){
        card.nickname = model.nickname
        card.location = model.location
        card.logo_discover = model.logo_discover
        card.watching_count = model.watching_count
        card.title = model.title
        card.logo_thumb = model.logo_thumb
        card.play_url = model.play_url
        card.vid = model.vid
    }
    




}

extension shoucangView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AgainCell", forIndexPath: indexPath) as! AgainCell
//        cell.model = dataArr[indexPath.row] as? AgainModel
        
        self.jieModel(dataArr[indexPath.row])
        cell.model = self.card
        cell.see.text = "在看"
        cell.creatCell()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 450
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let LiveView = LiveViewController()
        let model = dataArr[indexPath.row] //as! AgainModel
        
        LiveView.urlStr = model.play_url
        self.navigationController!.pushViewController(LiveView, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
    //可以左滑出现一个按钮，函数体内部就是按钮的点击事件
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataArr.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        NSKeyedArchiver.archiveRootObject(dataArr, toFile: path)
    }

    
    
    
}

