//
//  SignInVC.swift
//  chezhijia
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit



class SignInVC: ASBaseViewController {

   
    var phoneString = "^1\\d{10}$"
    @objc private lazy var leftImage : UIImageView = {
        let image = UIImageView.init()
        image.image =  image.imageWithColor(color: HedgeColor242)//ColorRGB(242, 242, 242)
        image.image = UIImage.init(color: HedgeColor242)
        return image
    }()
    
   private lazy var TitLabel :UILabel = {
        let label = UILabel.init()
        label.font = HedgeBoldFont24
        label.numberOfLines = 0
        var name = ""
        if let decoded = UserDefaults.standard.value(forKey: UserAccountNameKey){
            
           
            name = decoded as! String
        }
        label.text = "Hello！\(name)\n欢迎回来"
        label.textColor = HedColorWhite
        return label
    }()
    
    @objc private lazy var BarImage : UIImageView = {
        let image = UIImageView.init()
        image.image = UIImage.init(color: HedgeColor242)
        
        
        return image
    }()
    
   private lazy var userLabel:UIImageView = {
        let image = UIImageView.init()
        image.contentMode = .scaleAspectFit
        image.image = UIImage.init(named: "mima-icon")
        return image
    }()
  private lazy  var passLabel:UIImageView = {
        let image = UIImageView.init()
        image.contentMode = .scaleAspectFit
        image.image = UIImage.init(named: "shouji-icon")
        return image
    }()
//    let userLabel :UILabel = {
//        let label = UILabel.init()
//        label.font = HedgeTitleFont12
//        label.numberOfLines = 0
//        label.text = "手机号码"
//        label.textColor = RegwhiteColor
//        return label
//    }()
//    let passLabel :UILabel = {
//        let label = UILabel.init()
//        label.font = HedgeTitleFont12
//        label.numberOfLines = 0
//        label.text = "密码"
//        label.textColor = RegwhiteColor
//        return label
//    }()
   private lazy var userTextF :UITextField = {
        let TextF = UITextField.init()
        TextF.font = HedMediumFont16
        TextF.textColor = HedgColor51
        TextF.clearButtonMode = .whileEditing
        //        TextF.borderStyle = UITextBorderStyle.roundedRect

        TextF.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号", attributes: [NSAttributedStringKey.foregroundColor: HedgColor51])
//        TextF.keyboardType = .numberPad
        return TextF
    }()
  private lazy var passTextF :MyTextField = {
        let TextF = MyTextField.init()
        TextF.font = HedMediumFont16
        TextF.textColor = HedgColor51

        TextF.attributedPlaceholder = NSAttributedString.init(string: "请输入密码", attributes: [NSAttributedStringKey.foregroundColor: HedgColor51])
        TextF.clearButtonMode = .whileEditing
        TextF.isSecureTextEntry = true
        //        TextF.borderStyle = UITextBorderStyle.roundedRect
        return TextF
    }()
    
    
    
    
  private lazy  var userTextLin : UIView = {
        let label = UIView.init()
        label.backgroundColor = HedgColor239
        return label
    }()
   private lazy var passTextLin : UIView = {
        let label = UIView.init()
        label.backgroundColor = HedgColor239
        return label
    }()
    
  private lazy  var selectLabel : UILabel = {
        let label = UILabel.init()
        label.font = HedMediumFont12
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = HedgColor51
        label.text = "登录即代表同意"
        return label
    }()
    
  private lazy  var selectLin : UIButton = {
        let label = UIButton.init(type: .custom)
        label.titleLabel?.font = HedMediumFont12
        
        label.setTitle("《用户服务协议》", for: .normal)
        label.setTitleColor(HedgColor139, for: .normal)
        label.addTarget(self, action:#selector(ProtocolTapped(_:)), for: .touchUpInside)
        return label
    }()
    
  private lazy  var loginButton : UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = HedMediumFont16
        button.backgroundColor = HedgColor21
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action:#selector(tapped(_:)), for: .touchUpInside)
        return button
    }()
    
  private lazy  var eyeButton : UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "eye_close"), for: UIControlState.normal)
        button.setImage(UIImage.init(named: "eye_open"), for: UIControlState.selected)
        button.addTarget(self, action:#selector(eyeButtontapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    
   private lazy var SMSButton : UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = HedgeSysFont12

        button.setTitle("忘记密码", for: .normal)
        button.setTitleColor(HedgColor139, for: .normal)
        
        
        button.addTarget(self, action:#selector(tappedSMS(_:)), for: .touchUpInside)
        
        
        return button
    }()

    
 
    
 
    
 
    
    @objc func eyeButtontapped(_ button:UIButton) {
         passTextF.isSecureTextEntry = button.isSelected
        button.isSelected = !button.isSelected
       
    }
    
    @objc func tapped(_ button:UIButton) {
        button.isSelected = !button.isSelected
       view.endEditing(true)
        button.isEnabled = false
        //直接跳转
        rootVC()
        return   //下面的不会执行
      
        let account : String = userTextF.text!
        let password :String = passTextF.text!
        
        if account.validatePhonoNum(phono: account) == false{
            SVProgressHUD.showInfo(withStatus: "请输入正确手机号")
            return
        }

        if password.patternPasswor(phono: password) == false{
            SVProgressHUD.showInfo(withStatus: "密码错误")
            return
        }
        
        let params: [String: Any] = ["username":account,"password":password]
        SVProgressHUD.show()
        HedgehogProvider.request(.playlist(params,.post,OauthTokenURl,URLEncoding.default)){[weak self] result in
            SVProgressHUD.dismiss()
             button.isEnabled = true
            if let strongSelf = self {
                
                if case let .success(response) = result {
                    //解析数据
                    let jsonValue = try? response.mapJSON()
                    let data:Dictionary<String,Any> = jsonValue as? Dictionary ?? ["code":"400","msg":"数据错误"]
                    let isModel:SignInModel =  JSONDeserializer.deserializeFrom(dict: data)!
                    print(isModel.access_token)
                    if isModel.code.count == 0{
                        let dataWrite = NSKeyedArchiver.archivedData(withRootObject: isModel)
                        UserDefaults.standard.set(dataWrite, forKey: UserNameKey)
                        
                        
                        UserDefaults.standard.synchronize()
                        strongSelf.setGetData()
                        let parameters: Dictionary = [ "account": account,"password" : password]
                        
                        UserDefaults.standard.set(parameters, forKey: UserAccountKey)
                        UserDefaults.standard.synchronize()
                    
                    }else{
                         SVProgressHUD.showError(withStatus: isModel.message)
                    }
                }else{
                     SVProgressHUD.showError(withStatus: "登陆异常")
                }
                
               
            }
        }
    }
    
    func setGetData(){
        
        SVProgressHUD.show()
        HedgehogProvider.request(.playlist([:],.get,UserInfo,URLEncoding.default)){[weak self] result in
            if let strongSelf = self {
                SVProgressHUD.dismiss()
                if case let .success(response) = result {
                    //解析数据
                    let jsonValue = try? response.mapJSON()
                     let data:Dictionary<String,Any> = jsonValue as? Dictionary ?? ["code":"400","msg":"数据错误"]
                    let isModel:UserInfoModel =  JSONDeserializer.deserializeFrom(dict: data)!
                    if isModel.code == "0"{
                        strongSelf.rootVC()
                    }
                }
            }
            
        }
        
        

    }
    
    func rootVC(){
        
        if  ((self.presentingViewController) != nil) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: {
            UIApplication.shared.keyWindow?.rootViewController = ASTabBarViewController()
        })
        }else{
            UIApplication.shared.keyWindow?.rootViewController = ASTabBarViewController()
        }
        
    }

    @objc func tappedSMS(_ button:UIButton) {
//        button.isSelected = !button.isSelected
//        button.isEnabled = false
//        button.isEnabled = true
        let buttonName :String = (button.titleLabel?.text)!
        if buttonName == "忘记密码" {
            let vc = ResetPassVC()
            vc.title = "忘记密码"
            vc.dims = true
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    @objc func ProtocolTapped(_ button:UIButton) {
        button.isSelected = !button.isSelected
        button.isEnabled = false
        button.isEnabled = true
        setByPNPostData()
        

        
    }
   
    func setByPNPostData(){
        
        
        let vc = WKWebViewController()
        
        vc.gameUrl = "https://www.baidu.com"
        vc.title = "服务协议"
        vc.dims = true
        self.present(vc, animated: true, completion: nil)
        
        
    }

    
   
    
    
    
    
    @objc func tap(_ button:UIButton) {
        
        
    }
    /// 弹出清理缓存的提示框
//    func clearCacheAlertController() {
//        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//        let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
//            let cache = KingfisherManager.shared.cache
//            cache.clearDiskCache()
//            cache.clearMemoryCache()
//            cache.cleanExpiredDiskCache()
//        })
//        alertController.addAction(cancelAction)
//        alertController.addAction(okAction)
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        //        appDelegate.allowRotation = 0
//        //        self.navigationController?.navigationBar.isHidden = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 
        
        self.view.addSubview(BarImage)
        BarImage.easy.layout(Right(0),Left(0),Top(0),Height(screenWidth*3/5))
        BarImage.image = UIImage.init(named: "图层 5")
        
        
 
        
        
        self.view.backgroundColor = HedColorWhite
        
        
      
       
        
     
        self.view.addSubview(leftImage)
        leftImage.image = UIImage.init(named: "namept_")
        leftImage.easy.layout(CenterX(0),Width(42),Top(CGFloat(STATUS_BAR_HEIGHT)),Height(42))
        leftImage.layer.cornerRadius = 21
        leftImage.layer.masksToBounds = true
        leftImage.clipsToBounds = true
        
        self.view.addSubview(TitLabel)
        TitLabel.easy.layout(Right(33),Left(33),Top(15).to(leftImage))
        TitLabel.sizeToFit()
        TitLabel.textAlignment = .center
        
        self.view.addSubview(userLabel)
        userLabel.easy.layout(Width(20),Left(33),Top(34).to(BarImage),Height(20))
//        userLabel.textAlignment = .center
        
        self.view.addSubview(userTextF)
        userTextF.easy.layout(Right(33),Left(33),Top(8).to(userLabel),Height(32))
        self.view.addSubview(userTextLin)
        userTextLin.easy.layout(Right(33),Left(33),Top(0).to(userTextF),Height(1))
        
        self.view.addSubview(passLabel)
        
    passLabel.easy.layout(Width(20),Left(33),Top(18).to(userTextLin),Height(20))
        
        
        
        self.view.addSubview(passTextF)
        self.view.addSubview(eyeButton)
        eyeButton.easy.layout(Right(33),Width(33),Top(8).to(passLabel),Height(32))
        passTextF.easy.layout(Right(5).to(eyeButton),Left(33),Top(8).to(passLabel),Height(32))
        
        self.view.addSubview(passTextLin)
        passTextLin.easy.layout(Right(33),Left(33),Top(0).to(passTextF),Height(1))
        
        
        
        self.view.addSubview(loginButton)
        loginButton.easy.layout(Right(33),Left(33),Top(68).to(passTextLin),Height(50))
        
        
        self.view.addSubview(SMSButton)
        SMSButton.easy.layout(Right(33),Top(18).to(passTextLin))
        SMSButton.sizeToFit()
        
        
        self.view.addSubview(selectLabel)
        self.view.addSubview(selectLin)
        
        
        
        userTextF.delegate = self
        passTextF.delegate = self
        if UserDefaults.standard.value(forKey: UserAccountKey) != nil {
            let parameters = UserDefaults.standard.value(forKey: UserAccountKey) as! Dictionary<String, Any>
            
            userTextF.text =  parameters["account"] as? String
            passTextF.text = parameters["password"] as? String
            
        }
        
        
        let with = "登录即代表同意".ga_widthForComment(fontSize: HedMediumFont12!, height: 15)
        let withlin = "《用户服务协议》".ga_widthForComment(fontSize: HedMediumFont12!, height: 15)
      
        
        selectLabel.easy.layout(CenterX(-withlin/2),Top(25).to(loginButton),Width((with)),Height(12))
     
        
        selectLin.contentHorizontalAlignment = .left;
        
 
        
        selectLin.easy.layout(
            Top(25).to(loginButton),
            Left(0).to(selectLabel),
            Width(withlin),
            Height(12))
        
       
        selectLabel.isUserInteractionEnabled = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(tap(_:)))
        selectLabel.addGestureRecognizer(tap)
        
        
 
        //添加点击空白处回收键盘
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
   
    
    
   
    /// POP 返回到上一级控制器
    @objc private func popToParent() {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
extension SignInVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("我要开始编辑了...")
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
      
        if userTextF == textField{
            if userTextF.text?.length ?? 0 >= 11 && string != ""{
                return false
            }
            let text :String = textField.text ?? ""
            let texts :String = text + string
           
            let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
            
            
            if phonePredicate.evaluate(with: texts){
                //        if texts.validatePhonoNum(phono: texts){
//                loginButton.backgroundColor = HedgColor248
                if userTextF.text?.length ?? 0 == 11 && string == ""{
//                    loginButton.backgroundColor = HedgGraypageButtColor153.withAlphaComponent(0.7)
                }
            }else{
              
//                loginButton.backgroundColor = HedgGraypageButtColor153.withAlphaComponent(0.7)
            }
            
        }
        
        
        return true
    }
    
    
}
