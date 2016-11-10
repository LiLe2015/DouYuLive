//
//  UIBarButtonItem-Extension.swift
//  DouYuLive
//
//  Created by LiLe on 2016/11/10.
//  Copyright © 2016年 LiLe. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // MARK:- 类方法
    class func createItem(imageName: String, highlightedImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highlightedImageName), forState: .Highlighted)
        btn.frame = CGRect(origin: CGPointZero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    // MARK:- 便利构造函数
    // 便利构造函数：1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName: String, highlightedImageName: String = "", size: CGSize = CGSizeZero) {
        // 1.创建UIButton
        let btn = UIButton()
        
        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if highlightedImageName != "" {
            btn.setImage(UIImage(named: highlightedImageName), forState: .Highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSizeZero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        
        // 4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
