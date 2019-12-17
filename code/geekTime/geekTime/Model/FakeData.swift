//
//  FakeData.swift
//  geekTime
//
//  Created by zhj on 2019/11/23.
//  Copyright © 2019 geekbang. All rights reserved.
//

import Foundation

class FakeData {
    
    private static var bannerList = [String]()
    private static var products = [Product]()
    private static var deals = [Deal]()
    
    static func createBanners() -> [String] {
        if bannerList.count == 0 {
            bannerList = ["https://static001.geekbang.org/resource/image/30/86/307332b7ba9556ba1e38c358ad6aab86.jpg",
            "https://static001.geekbang.org/resource/image/4e/c5/4ea96e35e97f37914c1703d1cf4b69c5.jpg",
            "https://static001.geekbang.org/resource/image/f7/b4/f79b1fcb2e9eeb1002fd7db4b4fd10b4.jpg"
]
        }
        return bannerList
    }
    
    static func createProducts() -> [Product] {
        if products.count == 0 {
            let p1 = Product(imageUrl: "https://static001.geekbang.org/resource/image/87/ee/8778de4ccd67425a762cea15361639ee.jpg?x-oss-process=image/resize,m_fill,h_336,w_254", name: "MongoDB高手课", desc: "Tapdata CTO、MongoDB中文社区主席、前MongoDB大中华区首席架构师", price: 129, teacher: "唐建法", total: 47, update: 9, studentCount: 2205, detail: "MongoDB 是当前广受欢迎的 NoSQL 数据库，目前社...", courseList: "第一章：MongoDB再入门 (9讲)")
            let p2 = Product(imageUrl: "https://static001.geekbang.org/resource/image/a6/48/a6c8ecd93024e4ba483bd3800dac3148.jpg?x-oss-process=image/resize,m_fill,h_336,w_254", name: "JavaScript核心原理解析", desc: "重构你对JavaScript语言的认知", price: 129, teacher: "周爱民", total: 21, update: 4, studentCount: 2532, detail: "作为前端工程师必备技能，JavaScript 的重要性不言而喻。但是，很多人对 JavaScript 的印象都只是“简单易学”，对其掌握也仅仅停留在“会用就好”，以至于不求甚解、迷失于 JavaScript 。究其原因，他们从来都只是“写代码”，而没有去真正去了解、去探索“什么是语言”。.", courseList: "从零开始 (3讲)")
            let p3 = Product(imageUrl: "https://static001.geekbang.org/resource/image/cd/6c/cd7ba03722f906db730366de0d6f2d6c.jpg?x-oss-process=image/resize,m_fill,h_336,w_254", name: "设计模式之美", desc: "前Google工程师手把手教你写高质量代码", price: 129, teacher: "王争", total: 100, update: 7, studentCount: 1512, detail: "设计模式对你来说，应该不陌生。在面试中，经常会被问到；在工作中，有时候也会用到。一些设计模式书籍，比如大名鼎鼎的 GoF 的《设计模式》、通俗易懂的《Head First 设计模式》，估计你也都研读过。那你是否觉得自己已经掌握了设计模式呢？是否思考过怎么才算真正掌握了设计模式呢？是熟练掌握每种设计模式的原理和代码实现吗？", courseList: "开篇词 (1讲)")
            let p4 = Product(imageUrl: "https://static001.geekbang.org/resource/image/bb/e4/bb10501b8ec19b04755ce600ded53ee4.jpg?x-oss-process=image/resize,m_fill,h_336,w_254", name: "项目管理实战20讲", desc: "网易内部项目管理心法", price: 129, teacher: "雷蓓蓓", total: 20, update: 9, studentCount: 3122, detail: "当下，项目管理能力已经逐渐成为我们每一个人的必备技能。随着项目复杂度的增加、竞争压力的增大，只是做一名优秀的项目参与者是远远不够的。实际上，我们都应该成为拥有全局视角和主人翁意识的项目管理者。如果能够跨出自己的日常职责范围，主动推进项目目标的落地，促进各角色的高效协同运转，自己的职场精进之路将更加顺畅。而这一切，都离不开项目管理能力的支撑。", courseList: "开篇词(1讲)")

            products = [p1, p2, p3, p4]
        }
        return products
    }
    
    static func createDeals() -> [Deal] {
        if deals.count == 0 {
            deals = FakeData.createProducts().map {
                Deal(product: $0, progress: 1)
            }
        }
        return deals
    }
    
}
