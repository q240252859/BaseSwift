//
//  ResetPassVC.swift
//  chezhijia
//
//  Created by mac on 2019/1/24.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class ResetPassVC: ASBaseViewController {

    
    
        let userLabel :UILabel = {
            let label = UILabel.init()
            label.font = HedMediumFont16
            label.numberOfLines = 0
            label.text = "手机号码"
            label.textColor = HedgColor153
            return label
        }()
        let passLabel :UILabel = {
            let label = UILabel.init()
            label.font = HedMediumFont16
            label.numberOfLines = 0
            label.text = "请输入验证码"
            label.textColor = HedgColor153
            return label
        }()
    let userTextF :UITextField = {
        let TextF = UITextField.init()
        TextF.font = HedMediumFont16
        TextF.textColor = HedgColor51
        TextF.clearButtonMode = .whileEditing
        TextF.keyboardType = .numberPad
        //        TextF.borderStyle = UITextBorderStyle.roundedRect
        
//        TextF.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号", attributes: [NSAttributedStringKey.foregroundColor: HedgColor51])
        //        TextF.keyboardType = .numberPad
        return TextF
    }()
    let passTextF :MyTextField = {
        let TextF = MyTextField.init()
        TextF.font = HedMediumFont16
        TextF.textColor = HedgColor51
        
//        TextF.attributedPlaceholder = NSAttributedString.init(string: "请输入验证码", attributes: [NSAttributedStringKey.foregroundColor: HedgColor51])
        TextF.clearButtonMode = .whileEditing
        TextF.keyboardType = .numberPad
//        TextF.isSecureTextEntry = true
        //        TextF.borderStyle = UITextBorderStyle.roundedRect
        return TextF
    }()
    
    
    var dims = false
   
    
    let SMSButton : UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = HedgeSysFont12
        
        button.setTitle("发送验证码", for: .normal)
        button.setTitleColor(HedgColor139, for: .normal)
        
        
        button.addTarget(self, action:#selector(tappedSMS(_:)), for: .touchUpInside)
        
        
        return button
    }()
    
    let loginButton : UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = HedMediumFont16
        button.backgroundColor = HedgColor21
        button.setTitle("下一步", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action:#selector(tapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    @objc func tappedSMS(_ button:UIButton) {
        button.isSelected = !button.isSelected
        view.endEditing(true)
        button.isEnabled = false
        
       
        
        
        let account : String = userTextF.text!
        let password :String = passTextF.text!
        
        if account.validatePhonoNum(phono: account) == false{
            SVProgressHUD.showInfo(withStatus: "请输入正确手机号")
            button.isEnabled = true
            return
        }
        //
        //        if password.patternPasswor(phono: password) == false{
        //            SVProgressHUD.showInfo(withStatus: "密码错误")
        //            return
        //        }
        
        let params: [String: Any] = ["phone":account ]
        SVProgressHUD.show()
        HedgehogProvider.request(.playlist(params,.post,ApiSmsSendCode,URLEncoding.default)){[weak self] result in
            SVProgressHUD.dismiss()
            button.isEnabled = true
            if let strongSelf = self {
                
                if case let .success(response) = result {
                    //解析数据
                    let jsonValue = try? response.mapJSON()
                    let data:Dictionary<String,Any> = jsonValue as? Dictionary ?? ["code":"400","msg":"数据错误"]
                    let isModel:UserInfoModel =  JSONDeserializer.deserializeFrom(dict: data)!
                    
                    
                    if isModel.code == "0" || isModel.code == "200"{
                        //设置倒计时
                        CountDown.countDown(60 , btn: button)
                       SVProgressHUD.showSuccess(withStatus: "发送成功")
                    }else{
                        SVProgressHUD.showError(withStatus: isModel.msg)
                    }
                }
                
            }
            
        }
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = HedgeColor242
        if dims {
            self.LeftDims()
        }
        
        
        
        setUI()
        
      
    }
    

    
    func setUI(){
        view.addSubview(userLabel)
        userLabel.easy.layout(Right(15),Left(15),Top(CGFloat(NAVIGATION_BAR_HEIGHT)),Height(32))
        
        let userV = UIView.init()
        view.addSubview(userV)
        userV.easy.layout(Right(0),Left(0),Top(0).to(userLabel),Height(40))
        userV.addSubview(userTextF)
        userV.backgroundColor = HedColorWhite
        userTextF.easy.layout(Right(15),Left(15),CenterY(0),Height(34))
        
        
        view.addSubview(passLabel)
        passLabel.easy.layout(Right(15),Left(15),Top(0).to(userV),Height(32))
        
        let passV = UIView.init()
        view.addSubview(passV)
        passV.easy.layout(Right(0),Left(0),Top(0).to(passLabel),Height(40))
        passV.addSubview(passTextF)
        passV.backgroundColor = HedColorWhite
        passTextF.easy.layout(Right(15),Left(15),CenterY(0) ,Height(34))
        
        self.view.addSubview(SMSButton)
        SMSButton.easy.layout(Right(15),Top(10).to(passV))
        SMSButton.sizeToFit()
        
        self.view.addSubview(loginButton)
        loginButton.easy.layout(Right(33),Left(33),Top(58).to(passV),Height(50))
    }

    @objc func tapped(_ button:UIButton) {
        button.isSelected = !button.isSelected
        view.endEditing(true)
        button.isEnabled = false
        
        let account : String = userTextF.text!
        let password :String = passTextF.text!
        
        if account.validatePhonoNum(phono: account) == false{
            SVProgressHUD.showError(withStatus: "请输入正确手机号")
            button.isEnabled = true
            return
        }
        //
        //        if password.patternPasswor(phono: password) == false{
        //            SVProgressHUD.showInfo(withStatus: "密码错误")
        //            return
        //        }
        
//        let vc = newPassVC()
//        vc.title = "设置新密码"
//        vc.dims = true
//        vc.phone = account
//        button.isEnabled = true
//        self.present(vc, animated: true, completion: nil)
//        return
        
        
        let params: [String: Any] = ["phone":account,"code":password]
     
        SVProgressHUD.show()
        HedgehogProvider.request(.playlist(params,.post,ApiSmsVerify,URLEncoding.default)){[weak self] result in
            SVProgressHUD.dismiss()
            button.isEnabled = true
            if let strongSelf = self {
                
                if case let .success(response) = result {
                    //解析数据
                    let jsonValue = try? response.mapJSON()
                    let data:Dictionary<String,Any> = jsonValue as? Dictionary ?? ["code":"400","msg":"数据错误"]
                    let isModel:UserInfoModel =  JSONDeserializer.deserializeFrom(dict: data)!
                    if isModel.code == "0" || isModel.code == "200"{
                        
                        
//                        let vc = newPassVC()
//                        vc.title = "设置新密码"
//                        vc.dims = true
//                        vc.phone = account
//                        strongSelf.present(vc, animated: true, completion: nil)
                        
                        
                    }else{
                        SVProgressHUD.showError(withStatus: isModel.msg)
                    }
                     
                }
                
            }
            
        }
        
    }

}
class CountDown: NSObject {
    class func countDown(_ timeOut: Int, btn: UIButton){
        //倒计时时间
        var timeout = timeOut
        let queue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let _timer:DispatchSource = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        _timer.scheduleRepeating(wallDeadline: DispatchWallTime.now(), interval: .seconds(1))
        //每秒执行
        _timer.setEventHandler(handler: { () -> Void in
            if(timeout<=0){ //倒计时结束，关闭
                _timer.cancel();
                DispatchQueue.main.sync(execute: { () -> Void in
                    btn.setTitle("重新获取", for: UIControlState())
                    btn.isEnabled = true
//                    btn.layer.backgroundColor = RegwhiteColor.cgColor
                })
            }else{//正在倒计时
                let seconds = timeout
                let strTime = NSString.localizedStringWithFormat("%.2d", seconds)
                DispatchQueue.main.sync(execute: { () -> Void in
                    btn.isEnabled = false
                    btn.setTitle("\(timeout)", for: UIControlState.normal)
//                    btn.layer.backgroundColor = UIColor.gray.cgColor
                })
                timeout -= 1;
            }
        })
        _timer.resume()
    }
}
