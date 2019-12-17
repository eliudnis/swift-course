//
//  DealListViewController.swift
//  geekTime
//
//  Created by zhj on 2019/11/23.
//  Copyright © 2019 geekbang. All rights reserved.
//

import UIKit

class DealListViewController: BaseViewController, CommonListDelegate {
   
    func didSelectItem<Item>(_ item: Item) {
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let productList = CommonList<Deal, DealListCell>(frame: .zero)
        productList.items = FakeData.createDeals()
        productList.delegate = self
        view.addSubview(productList)
        productList.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
