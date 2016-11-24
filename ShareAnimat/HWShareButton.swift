//
//  HWShareButton.swift
//  ShareAnimat
//
//  Created by 韩威 on 2016/11/24.
//  Copyright © 2016年 Wei Han. All rights reserved.
//

import UIKit

class HWShareButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView?.image != nil {
            imageView!.frame = CGRect.init(
                x: (self.bounds.size.width - self.imageView!.image!.size.width) / 2.0,
                y: 0,
                width: imageView!.image!.size.width,
                height: imageView!.image!.size.height)
        }
        
        if titleLabel != nil {
            let titleLabelSize = getTitleLabelSize()
            titleLabel!.frame = CGRect.init(
                x: (self.bounds.size.width - titleLabelSize.width) / 2.0,
                y: imageView!.frame.maxY + 7.0,
                width: titleLabelSize.width,
                height: titleLabelSize.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        backgroundColor = UIColor.clear
//        frame = CGRect.init(x: 20, y: 20, width: 70, height: 80)
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.darkGray, for: .highlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
}

extension HWShareButton {
    func getTitleLabelSize() -> CGSize {
        guard titleLabel != nil else {
            return CGSize.zero
        }
        let size = titleLabel!.text!.getFitSize(maxSize: CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), font: titleLabel!.font)
        return size
    }
}

extension String {
    func getFitSize(maxSize: CGSize, font: UIFont? = UIFont.systemFont(ofSize: 14)) -> CGSize {
        let nsStr = NSString.init(string: self)
        let rect = nsStr.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: font!], context: nil)
        return rect.size
    }
}

extension HWShareButton {
    
    func shakeBtn(delay: TimeInterval) {
        let top1 = CGAffineTransform.init(translationX: 0, y: 150)
        let bottom1 = CGAffineTransform.init(translationX: 0, y: 3)
        let top2 = CGAffineTransform.init(translationX: 0, y: -8)
        let reset = CGAffineTransform.identity
        //0 初始状态 下
        self.transform = top1
        self.alpha = 0.3
        
        //1 上
        UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseOut, animations: {
            
            self.transform = top2
            self.alpha = 1
            
        }, completion: { _ in
            
            //2 下
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                
                self.transform = bottom1
                
            }, completion: { (_) in
                
                //3 还原
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
                    
                    self.transform = reset
                    
                }, completion: { (_) in
                    
                })  
            })
        })
    }
}

