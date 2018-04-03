//
//  CCYDisplayViewController.swift
//  DemoScroll
//
//  Created by CCY on 2018/3/27.
//  Copyright © 2018年 cn.com.momole. All rights reserved.
//

import UIKit

class CCYDisplayViewController: UIViewController {

    var childVCs : [UIViewController] = [];
    var titleView : TitleView?
    var contentScrollView : UICollectionView?
    var titleViewColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页";
        view.backgroundColor = UIColor.white;
        setUpContentScrollView();
        setUpTitleView();
    }
    
    private func setUpContentScrollView(){
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = view.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout);
        collectionView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0);
        collectionView.bounces = false;
        contentScrollView = collectionView;
        collectionView.isPagingEnabled = true;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        view.addSubview(collectionView);
    }
    
    func setUpChildViewController(){
        
        for childVC in childVCs {
            addChildViewController(childVC);
        }

    }
    
    private func setUpTitleView(){
        
        let titleV = TitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44));
        titleView = titleV;
        titleV.deleagate = self;
        if titleViewColor == nil{
            titleV.titleScrollView?.backgroundColor = UIColor.white;
        }else{
            titleV.titleScrollView?.backgroundColor = titleViewColor!;
        }
        
        view.addSubview(titleV);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension CCYDisplayViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childViewControllers.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath);
        //移除之前的子控件
        cell.contentView.subviews.forEach { (subView) in
            subView.removeFromSuperview();
        }
        
        let vc = childViewControllers[indexPath.row];
        cell.contentView.addSubview(vc.view);
        
        return cell;
    }
}

extension CCYDisplayViewController : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x;
        let index = Int(offsetX/kScreenWidth);
        
        if titleView?.titles.count != childVCs.count {
            print("error");
            return;
        }
        
        titleView?.titleScrollView?.scrollToItem(at: IndexPath(item: Int(index), section: 0), at: .centeredHorizontally, animated: true);
        
        if let cell = titleView?.titleScrollView?.cellForItem(at: IndexPath(item: titleView!.selectedIndex, section: 0)) as? TitleCollectionViewCell{
            cell.titleLabel?.textColor = UIColor.black;
        }
        titleView?.selectedIndex = index;
        if let cell = titleView?.titleScrollView?.cellForItem(at: IndexPath(item: titleView!.selectedIndex, section: 0)) as? TitleCollectionViewCell{
            cell.titleLabel?.textColor = UIColor.red;
        }
        
    }
}

extension CCYDisplayViewController : TitleViewDelegate{
    func clickTitle(index: Int) {
        let i = IndexPath(item: index, section: 0);
        contentScrollView?.scrollToItem(at: i, at: .centeredHorizontally, animated: true);
    }
}

