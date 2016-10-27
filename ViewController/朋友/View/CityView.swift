//
//  CityView.swift
//  Live
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 flyfeng. All rights reserved.
//

import UIKit

class CityView: UICollectionViewCell {

    var nav: UINavigationController?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.cyanColor()
//        self.loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
