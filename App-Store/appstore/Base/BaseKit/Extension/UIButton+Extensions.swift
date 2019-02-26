//
//  UIButton+Extensions.swift
//  chezhijia
//
//  Created by mac on 2019/1/14.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

extension UIButton {
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
///验证码倒计时
class RFCodeCountdownBtn:UIButton{
    ///验证码倒计时的起始秒数
    var maxTimer = 60
    
    var countDown = false{
        didSet{
            
            if oldValue != countDown{
                countDown ? startCountDown() : stopCountDown()
            }
        }
    }
    
    private var second = 0
    private var timer: Timer?
    ///倒计时显示
    private var timeLabel: UILabel!
    private var normalText: String!
    private var normalTextColor: UIColor!
    private var disabledText: String!
    private var disabledTextColor: UIColor!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setuptimeLabel()
    }
    
    deinit {
        countDown = false
    }
    
    // MARK: Setups
    private func setuptimeLabel() {
        normalText = title(for: .normal)!
        disabledText = title(for: .disabled)!
        normalTextColor = UIColor .red
        disabledTextColor = UIColor .green
        setTitle("", for: .normal)
        setTitle("", for: .disabled)
        timeLabel = UILabel(frame:bounds)
        timeLabel.textAlignment = .center
        timeLabel.font = titleLabel?.font
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
        addSubview(timeLabel)
    }
    
    // MARK: Private
    private func startCountDown() {
        second = maxTimer
        updateDisabled()
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(RFCodeCountdownBtn.updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountDown() {
        timer?.invalidate()
        timer = nil
        updateNormal()
    }
    
    private func updateNormal() {
        isEnabled = true
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
    }
    
    private func updateDisabled() {
        isEnabled = false
        timeLabel.textColor = ColorRGB(255, 200, 10)
        timeLabel.text = "重新发送" + String(second) + "'"
    }
    
    @objc private func updateCountdown() {
        //        print("second == \(second)")
        if second <= 1 {
            countDown = false
        } else {
            second = second - 1
            updateDisabled()
        }
    }
}
