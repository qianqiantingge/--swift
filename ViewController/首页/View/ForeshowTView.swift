//
//  ForeshowTView.swift
//  Live
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class ForeshowTView: UIViewController {
    
    @IBOutlet var im: UIImageView!
    @IBOutlet var titleL: UILabel!
    @IBOutlet var timeL: UILabel!
    @IBOutlet var nL: UILabel!
    
    var model: ForesshowModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "预测详情"
        self.setSelf()
        // Do any additional setup after loading the view.
    }
    
    func setSelf(){
        
        self.im.sd_setImageWithURL(NSURL.init(string: model!.thumb!))
        self.im.sd_setImageWithURL(NSURL.init(string: (model!.thumb)!))
        self.titleL.text = model?.title!
        self.timeL.text = model?.live_start_time!
        self.nL.text = "        " + model!.desc!
    }
    

}
