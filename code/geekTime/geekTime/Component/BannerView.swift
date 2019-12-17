//
//  BannerView.swift
//  geekTime
//
//  Created by zhj on 2019/11/23.
//  Copyright © 2019 geekbang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol BannerViewDataSource: AnyObject {
    func numberOfBanners(_ bannerView: BannerView) -> Int
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView
}

protocol BannerViewDelegate: AnyObject {
    func didSelectBanner(_ bannerView: BannerView, index: Int)
}

class BannerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView
    var flowLayout: UICollectionViewFlowLayout
    
    var pageControl: UIPageControl
    
    weak var dataSource: BannerViewDataSource! {
        didSet {
            pageControl.numberOfPages = self.dataSource.numberOfBanners(self)
            collectionView.reloadData()
            if isInfinite {
                DispatchQueue.main.async {
                    self.collectionView.setContentOffset(CGPoint(x: self.collectionView.frame.width, y: 0), animated: false)
                }
            }
        }
    }
    weak var delegate: BannerViewDelegate?
    
    var autoScrollInterval: Float = 0 {
        didSet {
            if self.autoScrollInterval > 0 {
                self.startAutoScroll()
            } else {
                self.stopAutoScroll()
            }
        }
    }
    var isInfinite: Bool = true
    var timer: Timer?
    
    static var cellId = "bannerViewCellId"
    static var convertViewTag = 10086
    
    override init(frame: CGRect) {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: flowLayout)
        pageControl = UIPageControl()
        super.init(frame: frame)
        self.setupViews()
    }
    
    func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BannerView.cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pageNumber = dataSource.numberOfBanners(self)
        if isInfinite {
            if pageNumber == 1 {
                return 1
            } else {
                return pageNumber + 2
            }
        } else {
            return pageNumber
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerView.cellId, for: indexPath)
        var index = indexPath.row
        if isInfinite {
            let pageNumber = dataSource.numberOfBanners(self)
            if pageNumber > 1 {
                if indexPath.row == 0 {
                    index = pageNumber - 1
                } else if indexPath.row == pageNumber + 1 {
                    index = 0
                } else {
                    index = indexPath.row - 1
                }
            }
        }
        
        if let view = cell.contentView.viewWithTag(BannerView.convertViewTag) {
            let _ = dataSource.viewForBanner(self, index: index, convertView: view)
        } else {
            let newView = dataSource.viewForBanner(self, index: index, convertView: nil)
            newView.tag = BannerView.convertViewTag
            cell.contentView.addSubview(newView)
            newView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        return cell
    }
    
    func startAutoScroll()  {
        guard autoScrollInterval > 0 && timer == nil else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(autoScrollInterval), target: self, selector: #selector(flipNext), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopAutoScroll() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    @objc func flipNext() {
        guard let _ = superview, let _ = window else {
            return
        }
        
        let totalPageNumber = dataSource.numberOfBanners(self)
        guard totalPageNumber > 1 else {
            return
        }
        
        let currentPageNumber = Int(round(collectionView.contentOffset.x / collectionView.frame.width))
        
        if isInfinite {
            let nextPageNumber = currentPageNumber + 1
            collectionView.setContentOffset(CGPoint(x: collectionView.frame.width * CGFloat(nextPageNumber), y: 0), animated: true)
            if nextPageNumber >= totalPageNumber + 1 {
                pageControl.currentPage = 0
            } else {
                pageControl.currentPage = nextPageNumber - 1
            }
        } else {
            var nextPageNumber = currentPageNumber + 1
            if nextPageNumber >= totalPageNumber {
                nextPageNumber = 0
            }
            collectionView.setContentOffset(CGPoint(x: collectionView.frame.width * CGFloat(nextPageNumber), y: 0), animated: true)
            pageControl.currentPage = nextPageNumber
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let total = dataSource.numberOfBanners(self)
        let current = Int(round(collectionView.contentOffset.x / collectionView.frame.width))
        if current >= total + 1 {
            collectionView.setContentOffset(CGPoint(x: collectionView.frame.width, y: 0), animated: false)
        }
    }
    
    
}


