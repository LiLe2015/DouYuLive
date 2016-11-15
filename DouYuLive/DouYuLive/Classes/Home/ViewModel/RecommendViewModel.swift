//
//  RecommendViewModel.swift
//  DouYuLive
//
//  Created by LiLe on 2016/11/15.
//  Copyright © 2016年 LiLe. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    // MARK:- 懒加载属性
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback: () -> ()) {
        // 1.定义参数
        let parameterStr = "limit=4&offset=0&time="+NSDate.getCurrentTime()
        
        // 2.创建Group
        let dGroup = dispatch_group_create()
        
        // 3.请求第一部分推荐的数据
        dispatch_group_enter(dGroup)
        NetworkTools.POSTACtion("http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: "time="+NSDate.getCurrentTime()) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String: NSObject] else { return }
            
            // 2.根据data的key获取对应的数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }

            // 3.遍历字典，并且转成模型对象
            // 3.1.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 3.3.离开组
            dispatch_group_leave(dGroup)
            print("请求到0组的数据")
        }
        
        // 4.请求第二部分颜值数据
        dispatch_group_enter(dGroup)
        NetworkTools.POSTACtion("http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameterStr) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String: NSObject] else { return }
            
            // 2.根据data的key获取对应的数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典，并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3.离开组
            dispatch_group_leave(dGroup)
            print("请求到1组的数据")
        }
        
        // 5.请求2-12部分游戏数据
        dispatch_group_enter(dGroup)
        NetworkTools.POSTACtion("http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameterStr) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String: NSObject] else { return }
            
            // 2.根据data的key获取对应的数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历数组，获取字典，并将字典转成模型对象,kvc方式
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            // 4.离开组
            dispatch_group_leave(dGroup)
            print("请求到2-12组的数据")
        }
        
        // 6.所有的数据都请求到之后进行排序
        dispatch_group_notify(dGroup, dispatch_get_main_queue()) { 
            print("请求到所有的数据")
            self.anchorGroups.insert(self.prettyGroup, atIndex: 0)
            self.anchorGroups.insert(self.bigDataGroup, atIndex: 0)
            
            finishCallback()
        }
    }
}
