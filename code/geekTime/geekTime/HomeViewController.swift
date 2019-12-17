//
//  HomeViewController.swift
//  geekTime
//
//  Created by zhj on 2019/11/23.
//  Copyright © 2019 geekbang. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController, BannerViewDataSource, CommonListDelegate {
    
    func didSelectItem<Item>(_ item: Item) {
        if let product = item as? Product {
            let detailVC = DetailViewController()
            detailVC.product = product
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = false
    }
    
    func numberOfBanners(_ bannerView: BannerView) -> Int {
        return FakeData.createBanners().count
    }
    
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView {
        if let view = convertView as? UIImageView {
            view.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return view
        } else {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return imageView
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
        bannerView.autoScrollInterval = 2
        bannerView.isInfinite = true
        bannerView.dataSource = self
        view.addSubview(bannerView)
        
        let productList = CommonList<Product, ProductCell>(frame: .zero)
        productList.items = FakeData.createProducts()
        productList.delegate = self
        view.addSubview(productList)
        productList.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bannerView.snp_bottom).offset(5)
        }
    }
    
    
    
    
}
