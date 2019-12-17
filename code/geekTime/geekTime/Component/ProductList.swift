//
//  ProductList.swift
//  geekTime
//
//  Created by zhj on 2019/11/23.
//  Copyright © 2019 geekbang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ProductCell: CommonListCell<Product> {
    
    let priceLabel: UILabel
    let productImageView: UIImageView
       
    override var item: Product? {
           didSet {
               if let p = self.item {
                   self.productImageView.kf.setImage(with: URL(string: p.imageUrl))
                   self.textLabel?.text = p.name
                   self.detailTextLabel?.text = p.desc
                   self.priceLabel.text = "￥\(p.price)"
               }
           }
       }
       
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           priceLabel = UILabel(frame: .zero)
           productImageView = UIImageView()
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           self.setupViews()
       }
       
       private func setupViews() {
           textLabel?.textColor = UIColor.hexColor(0x333333)
           detailTextLabel?.textColor = UIColor.hexColor(0x999999)
           detailTextLabel?.numberOfLines = 2
           priceLabel.textColor = UIColor.hexColor(0xe23b41)
           priceLabel.font = UIFont.systemFont(ofSize: 15)
           productImageView.contentMode = .scaleAspectFill
           productImageView.clipsToBounds = true
           
           contentView.addSubview(priceLabel)
           contentView.addSubview(productImageView)
           
           productImageView.snp.makeConstraints({ (make) in
               make.left.equalTo(contentView).offset(20)
               make.top.equalTo(contentView).offset(10)
               make.width.equalTo(80)
               make.height.equalTo(100)
           })
           
           textLabel?.snp.makeConstraints({ (make) in
               make.left.equalTo(productImageView.snp_right).offset(12)
               make.top.equalTo(productImageView)
               make.right.equalTo(contentView).offset(-20)
           })
           
           priceLabel.snp.makeConstraints { (make) in
               make.left.equalTo(textLabel!)
               make.centerY.equalTo(contentView)
           }
           
           detailTextLabel?.snp.makeConstraints({ (make) in
               make.left.equalTo(textLabel!)
               make.bottom.equalTo(productImageView)
               make.right.equalTo(contentView).offset(-20)
           })
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}


