//
//  FindViewController.swift
//  Live
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {
    
     var lastBtn: UIButton?
    
    
//MARK: - 懒加载ControllectionView
    lazy var contentView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        //设置为横向滚动
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let contentView = UICollectionView.init(frame: CGRectMake(0, 44, SCREEN_W, SCREEN_H - 44 - 49), collectionViewLayout: layout)
        contentView.contentOffset = CGPointMake(SCREEN_W, 0)
        contentView.backgroundColor = GRAYCOLOR
        //设置按页滚动
        contentView.pagingEnabled = true
        contentView.showsHorizontalScrollIndicator = false

        contentView.registerClass(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        contentView.registerClass(LiveCell.self, forCellWithReuseIdentifier: "LiveCell")

        //指定数据源代理和操作代理
        contentView.delegate = self
        contentView.dataSource = self
        self.view.addSubview(contentView)
        return contentView
    }()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        self.setNav()
        self.contentView.reloadData()
//        self.loadData()

        
    }

//设置导航条
    func setNav(){        
        
            //放置btn的View
            let titleView = UIView.init(frame: CGRect(x: 0, y: -20, width: SCREEN_W / 5 * 3, height: NAV_H - 36))
            titleView.backgroundColor = UIColor.whiteColor()
            titleView.layer.masksToBounds = true
            titleView.layer.cornerRadius = 14
            self.navigationItem.titleView = titleView
            
            let bView = UIView.init()
            bView.frame = CGRect.init(x: 3, y: 3, width: titleView.frame.size.width - 6, height: titleView.frame.size.height - 6)
            bView.layer.masksToBounds = true
            bView.layer.cornerRadius = 10
            bView.backgroundColor = UIColor.redColor()
            titleView.addSubview(bView)
            
            let cView = UIView.init(frame: CGRect.init(x: SCREEN_W / 10 * 3 + 5, y: 2, width: SCREEN_W / 10 * 3 - 10, height: NAV_H - 10 - 36))
            cView.layer.masksToBounds = true
            cView.layer.cornerRadius = 10
            cView.backgroundColor = UIColor.whiteColor()
            cView.tag = 11
            bView.addSubview(cView)
            
            let titleArr = ["同城视频", "同城直播"]
            //导航中间的三个btn
            for i in 0...1 {
                let btn = UIButton.init(frame: CGRect.init(x: CGFloat(i) * SCREEN_W / 10 * 3 + 5, y: 2, width: SCREEN_W / 10 * 3 - 10, height: NAV_H - 10 - 30))
                btn.setTitle(titleArr[i], forState: UIControlState.Normal)
                btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 15
                btn.titleLabel?.font = UIFont.systemFontOfSize(14)
                btn.tag = 20 + i
                if i == 1 {
                    btn.selected = true
                    self.lastBtn = btn
                }
                btn.addTarget(self, action: #selector(self.headBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                titleView.addSubview(btn)
            }
        

        
    }
    
    func selectedIndex(index:NSInteger){
        let sender = self.navigationController?.view.viewWithTag(20 + index) as? UIButton
        self.headBtnClick(sender!)
    }
    
    func headBtnClick(sender: UIButton){
        if sender == lastBtn {
            return
        }
        lastBtn?.selected = false
        lastBtn = sender
        lastBtn?.selected = true
        let view = self.navigationController?.view.viewWithTag(11)
        UIView.animateWithDuration(0.25) {
            view?.frame.origin.x = (self.lastBtn?.frame.origin.x)! - 3
        }
        self.contentView.contentOffset.x = (CGFloat(sender.tag) - 20) * SCREEN_W
    }

    
    
}


//MARK: - CollectionView的协议方法
extension FindViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cellID = ""
        if indexPath.item == 0
        {
            cellID = "VideoCell"
            let cell = contentView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! VideoCell
            cell.nav = self.navigationController
//            cell.headView = self.headerView
            return cell
        }
            cellID = "LiveCell"
            let cell = contentView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! LiveCell
            cell.nav = self.navigationController
//            cell.headView = self.headerView
            return cell
  
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(SCREEN_W, SCREEN_H)
    }
    
    //结束滚动时
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = NSInteger(scrollView.contentOffset.x / SCREEN_W)
        self.selectedIndex(index)
    }
    
}

