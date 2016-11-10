//
//  UIColor-Extension.swift
//  DouYuLive
//
//  Created by LiLe on 2016/11/10.
//  Copyright © 2016年 LiLe. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
