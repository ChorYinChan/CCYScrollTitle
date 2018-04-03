//
//  TitleCollectionViewCell.swift
//  DemoScroll
//
//  Created by CCY on 2018/3/27.
//  Copyright © 2018年 cn.com.momole. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    var titleButton : UIButton?
    var titleLabel : UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame);
       // let button = UIButton(frame: bounds);
        //titleButton = button;
        //addSubview(button);
        let label = UILabel(frame: bounds);
        titleLabel = label;
        label.textAlignment = .center;
        addSubview(label);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
