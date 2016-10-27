//
//  LiveCell.swift
//  Live
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class LiveCell: UICollectionViewCell {

    //MARK: - 声明属性
    var dataArr:NSMutableArray! = NSMutableArray()
    var start = 0
    var nav: UINavigationController?
    var headView: UIView?
    //MARK: - 懒加载
    lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: CGRectMake(0, 44, SCREEN_W, SCREEN_H - 44 - 49), style: UITableViewStyle.Plain)
        tableView.registerNib(UINib.init(nibName: "AgainCell", bundle: nil), forCellReuseIdentifier: "AgainCell")
        self.contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.headView
        tableView.header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.start = 0
            self.loadData()
        })
        tableView.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.start += 20
            self.loadData()
        })
        return tableView
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.yellowColor()
        self.loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 网络请求
    func loadData(){
        HDManager.startLoading()
        
        AgainModel.requestAgainData(start) { (array, error) in
            if error == nil {
                if self.start == 0
                {
                    self.dataArr.removeAllObjects()
                }
                for model in array!{
                    if model.location != "哈尔滨"{
                        continue
                    }
                    if model.play_url == nil{
                        continue
                    }
                    self.dataArr.addObject(model)
                }
                //self.dataArr.addObjectsFromArray(array! as [AnyObject])
                self.tableView.reloadData()
                self.tableView.header.endRefreshing()
                self.tableView.footer.endRefreshing()
                
            }
            
            HDManager.stopLoading()
        }
        
    }
    
    
    
}



//MARK: - tableview的协议方法
extension LiveCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AgainCell", forIndexPath: indexPath) as! AgainCell
        cell.model = dataArr[indexPath.row] as? AgainModel
        cell.see.text = "在看"
        cell.creatCell()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 450
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let LiveView = LiveViewController()
        let model = dataArr[indexPath.row] as! AgainModel
        LiveView.urlStr = model.play_url
        self.nav?.pushViewController(LiveView, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
    
}

