//
//  HWShareView.swift
//  ShareAnimat
//
//  Created by 韩威 on 2016/11/24.
//  Copyright © 2016年 Wei Han. All rights reserved.
//

import UIKit

let selfHeight: CGFloat = 290

class HWShareView: UIView {
    
    // MARK: - Propertites
    fileprivate lazy var bgView: UIView = {
        let view = UIView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight - selfHeight)
        btn.addTarget(self, action: #selector(HWShareView.bgTap), for: .touchUpInside)
        view.addSubview(btn)
        view.addSubview(self)
        return view
    }()
    
    @objc func bgTap() {
        cancle()
    }
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    @IBOutlet weak var topScrollView: UIScrollView!
    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    private func setup() {

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        self.frame = CGRect.init(x: 0, y: .screenHeight, width: .screenWidth, height: selfHeight)
        
        let imgArrary = ["alishq_allshare_60x60_", "weixin_allshare_60x60_", "qq_allshare_60x60_", "qqkj_allshare_60x60_", "sina_allshare_60x60_", "qqwb_allshare_60x60_", "aliplay_allshare_60x60_", "alishq_allshare_60x60_"]
        let titleArray = ["微信朋友圈", "微信好友", "手机QQ", "QQ空间", "新浪微博", "腾讯微博", "支付宝好友", "支付宝生活圈"]
        setScrollViewContent(withScrollView: topScrollView, imgArray: imgArrary, titleArray: titleArray)
        
        
        let imgArrary2 = ["airdrop_allshare_60x60_", "link_allshare_60x60_", "mail_allshare_60x60_", "copy_allshare_60x60_"]
        let titleArray2 = ["系统分享", "信息", "邮件", "复制链接"]
        setScrollViewContent(withScrollView: bottomScrollView, imgArray: imgArrary2, titleArray: titleArray2)
        
    }
    
    fileprivate func setScrollViewContent(withScrollView scrollView: UIScrollView, imgArray: [String], titleArray: [String]) {
        
        let btnW: CGFloat = 76
        let btnH: CGFloat = 90
        let btnY: CGFloat = scrollView == topScrollView ? 23 : 15
        let margin: CGFloat = 18
        var btnX: CGFloat = 0
        
        for (index, value) in imgArray.enumerated() {
            
            btnX = btnW * CGFloat(index) + margin
            
            let btn = HWShareButton(type: .custom)
            btn.frame = CGRect.init(x: btnX, y: btnY, width: btnW, height: btnH)
            btn.setImage(UIImage.init(named: value), for: .normal)
            btn.setTitle(titleArray[index], for: .normal)
            scrollView.addSubview(btn)
            
            if index == imgArray.count - 1 {
                scrollView.contentSize = CGSize.init(width: btn.frame.maxX + margin, height: btnH)
            }
        }
        
        
    }
    
    @IBAction func cancle() {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.frame.origin.y = CGFloat.screenHeight
            
        }, completion: { _ in
            
            self.bgView.removeFromSuperview()
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func show() {
        let topWindow = UIApplication.shared.windows.last!
        topWindow.addSubview(bgView)
        
        var delay: TimeInterval = 0
        var i: TimeInterval = 0
        for subview in self.allSubviews() {
            if subview is HWShareButton {
                if i == 5 {
                    delay = 0
                }
                delay += 0.05
                i += 1
                
                let btn = subview as! HWShareButton
                btn.shakeBtn(delay: delay)
            }
        }
        
        self.alpha = 0
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.alpha = 1
            self.frame.origin.y = CGFloat.screenHeight - selfHeight
            
        }, completion: { _ in
            
        })
    }
    
    class func getView() -> HWShareView {
        let view = HWShareView.loadViewFromXib()
        return view as! HWShareView
    }
}




