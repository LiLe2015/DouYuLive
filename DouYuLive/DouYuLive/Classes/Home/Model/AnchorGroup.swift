//
//  AnchorGroup.swift
//  DouYuLive
//
//  Created by LiLe on 2016/11/15.
//  Copyright © 2016年 LiLe. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组对应的房间信息
    var room_list: [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }

        }
    }
    /// 组显示的标题
    var tag_name: String = ""
    /// 组显示的图标
    var icon_name: String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    // 构造函数
    override init() {
        
    }
    
    init(dict: [String : NSObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    /*
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
   */
}
