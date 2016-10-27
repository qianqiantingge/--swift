//
//  LiveViewController.swift
//  Live
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController, VMediaPlayerDelegate {

    var urlStr: String?
    let mMPayer = VMediaPlayer.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
        mMPayer.setupPlayerWithCarrierView(self.view, withDelegate: self)
        let url = NSURL.init(string: urlStr!)
        mMPayer.setDataSource(url)
        mMPayer.prepareAsync()
        let lbtn = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.didClicker))
        self.navigationItem.leftBarButtonItem = lbtn

    }

    func quicklyStopMovie(){
        mMPayer.reset()
        mMPayer.unSetupPlayer()
        UIApplication.sharedApplication().idleTimerDisabled = false
        
    }
    
    
    func didClicker(){
        self.quicklyStopMovie()
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    func mediaPlayer(player: VMediaPlayer!, didPrepared arg: AnyObject!) {
        player.start()
    }
    
    func mediaPlayer(player: VMediaPlayer!, playbackComplete arg: AnyObject!) {
        player.reset()
    }
    
    func mediaPlayer(player: VMediaPlayer!, error arg: AnyObject!) {
        print("aaaaaa\(arg)")
    }

}
