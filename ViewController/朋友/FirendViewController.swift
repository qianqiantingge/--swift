//
//  FirendViewController.swift
//  Live
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class FirendViewController: UIViewController {
    
    var lastBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyanColor()
        self.setNav()
        self.contentView.reloadData()

        // Do any additional setup after loading the view.
    }

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
        //注册关注页面cell
        contentView.registerClass(RankingView.self, forCellWithReuseIdentifier: "RankingView")
        //        //注册推荐cell
        contentView.registerClass(ConcernView.self, forCellWithReuseIdentifier: "ConcernView")
        contentView.registerClass(CityView.self, forCellWithReuseIdentifier: "CityView")
        //指定数据源代理和操作代理
        contentView.delegate = self
        contentView.dataSource = self
        self.view.addSubview(contentView)
        return contentView
    }()
    

    

    //MARK: - 设置导航
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
        
        let cView = UIView.init(frame: CGRect.init(x: SCREEN_W / 5 + 5, y: 2, width: SCREEN_W / 5 - 10, height: NAV_H - 10 - 36))
        cView.layer.masksToBounds = true
        cView.layer.cornerRadius = 10
        cView.backgroundColor = UIColor.whiteColor()
        cView.tag = 11
        bView.addSubview(cView)
        
        let titleArr = ["排行", "关注", "同城"]
        //导航中间的三个btn
        for i in 0...2 {
           let btn = UIButton.init(frame: CGRect.init(x: CGFloat(i) * SCREEN_W / 5 + 5, y: 2, width: SCREEN_W / 5 - 10, height: NAV_H - 10 - 30))
            btn.setTitle(titleArr[i], forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 15
            btn.tag = 20 + i
            btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            if i == 1 {
                btn.selected = true
                //                btn.backgroundColor = UIColor.whiteColor()
                self.lastBtn = btn
            }
            btn.addTarget(self, action: #selector(self.headBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            titleView.addSubview(btn)
        }
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
    func selectedIndex(index:NSInteger){
        let sender = self.navigationController?.view.viewWithTag(20 + index) as? UIButton
        self.headBtnClick(sender!)
    }
    

}

//MARK: - CollectionView的协议方法
extension FirendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cellID = ""
        if indexPath.item == 0
        {
            cellID = "RankingView"
            let cell = contentView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! RankingView
            cell.nav = self.navigationController

            return cell
        }else if indexPath.item == 1{
            cellID = "ConcernView"
            let cell = contentView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! ConcernView
            cell.nav = self.navigationController

            return cell
        }else{
            cellID = "CityView"
        }
        
        let cell = contentView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CityView
        cell.nav = self.navigationController
        
        
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


