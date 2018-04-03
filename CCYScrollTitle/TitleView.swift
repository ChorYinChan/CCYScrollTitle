//
//  TitleView.swift
//  DemoScroll
//
//  Created by CCY on 2018/3/27.
//  Copyright © 2018年 cn.com.momole. All rights reserved.
//

import UIKit

protocol TitleViewDelegate : NSObjectProtocol {
    func clickTitle(index : Int)->Void;
}

class TitleView: UIView {
    weak var deleagate : TitleViewDelegate?
    let kWidth : CGFloat = UIScreen.main.bounds.width * 0.25;
    let kHeight : CGFloat = 44;
    var titles : [String] = [];
    var selectedIndex : Int = 0;
    var titleScrollView : UICollectionView?
    override init(frame: CGRect) {
        super.init(frame: frame);
        setUpCollectionView();
    }
    
    private func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kWidth, height: kHeight);
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout);
        titleScrollView = collectionView;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.addSubview(collectionView);
        
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TitleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = titles[indexPath.item];
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TitleCollectionViewCell{
            cell.titleLabel?.text = model;
            if selectedIndex == indexPath.row{
                cell.titleLabel?.textColor = UIColor.red;
            }
            if indexPath.row == 0,selectedIndex != 0{
                cell.titleLabel?.textColor = UIColor.black;
            }
           
            return cell;
        }
        return UICollectionViewCell();
    }
}

extension TitleView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        titleScrollView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true);
        
        //把之前选中的第一个效果去掉
        if let cell = collectionView.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as? TitleCollectionViewCell{
            cell.titleLabel?.textColor = UIColor.black;
        }
        selectedIndex = indexPath.row;
        if let cell = collectionView.cellForItem(at: indexPath) as? TitleCollectionViewCell{
            cell.titleLabel?.textColor = UIColor.red;
        }
        deleagate?.clickTitle(index: indexPath.row);
    }
}
