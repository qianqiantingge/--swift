//
//  ForeshowView.swift
//  Live
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class ForeshowView: UICollectionViewCell {
//MARK: - 声明属性
    var dataArr:NSMutableArray! = NSMutableArray()
    var start = 0
    var nav: UINavigationController?
    var headView: UIView?
    
//MARK: - 懒加载
    lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: CGRectMake(0, NAV_H-5, SCREEN_W, SCREEN_H - 44 - 49), style: UITableViewStyle.Plain)
        tableView.registerNib(UINib.init(nibName: "ForeshowCell", bundle: nil), forCellReuseIdentifier: "ForeshowCell")
        self.contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
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
        ForesshowModel.requestForesshowData(start) { (array, error) in
            if error == nil {
                if self.start == 0 {
                    self.dataArr.removeAllObjects()
                }

                self.dataArr.addObjectsFromArray(array! as [AnyObject])
                self.tableView.reloadData()
                self.tableView.header.endRefreshing()
                self.tableView.footer.endRefreshing()
            }
     
            HDManager.stopLoading()
        }
     
     }

 
    
    
    
}




//MARK: - tableview的协议方法
extension ForeshowView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ForeshowCell", forIndexPath: indexPath) as! ForeshowCell
        cell.model = dataArr[indexPath.row] as? ForesshowModel
        
        cell.creatCell()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 400
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let view = ForeshowTView()
        view.model = dataArr[indexPath.row] as? ForesshowModel
        
//        view.setSelf()
        self.nav?.pushViewController(view, animated: true)
    }
    
}






