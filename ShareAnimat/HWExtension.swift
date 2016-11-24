//
//  HWExtension.swift
//  ShareAnimat
//
//  Created by 韩威 on 2016/11/24.
//  Copyright © 2016年 Wei Han. All rights reserved.
//

import CoreGraphics
import UIKit

extension CGFloat {
    /// 屏幕的宽
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    /// 屏幕的高
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

extension CGSize {
    /// 屏幕的大小
    public static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}

extension UIView {
    // 1-> 3,4   2-> 5,6
    func allSubviews() -> [UIView] {
        var res = self.subviews //1,2   3,4
        for subview in self.subviews {
            // subview = 1
            let riz = subview.allSubviews()
            // riz = 3,4
            res.append(contentsOf: riz)
        }
        return res
    }
    
    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}

extension UIView {
    class func loadViewFromXib() -> UIView {
        let className = String(describing: self)
        let view = Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.last as! UIView
        return view
    }
}
