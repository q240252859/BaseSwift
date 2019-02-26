

import UIKit
//微信appid
let WX_APPID=""
//AppSecret
let SECRET=""

class AliPayManager:NSObject{
    static let shared = AliPayManager()
    // 用于弹出警报视图，显示成功或失败的信息
    fileprivate weak var sender: UIViewController!
    // 支付成功的闭包
    fileprivate var paySuccessClosure: (() -> Void)?
    // 支付失败的闭包
    fileprivate var payFailClosure: (() -> Void)?
    ///登录成功的闭包
    fileprivate var loginSuccessClosure:((_ auth_code:String) -> Void)?
    ///登录失败的闭包
    fileprivate var loginFailClosure:(() -> Void)?
    // 外部用这个方法调起支付支付
    func payAlertController(_ sender: UIViewController,
                            request:String,
                            paySuccess: @escaping () -> Void,
                            payFail:@escaping () -> Void) {
        // sender 是调用这个方法的控制器，
        self.sender = sender
        //用于提示用户支付宝支付结果，可以根据自己需求是否要此参数。
        self.paySuccessClosure = paySuccess
        self.payFailClosure = payFail
//        AlipaySDK.defaultService().payOrder(request, fromScheme:"ciweilive.com") { (result) in
//            print("支付宝支付结果\(String(describing: result))")
//            self.showAuth_V2Result(result: result as! NSDictionary)
//        }
    }
    //外部用这个方法调起支付宝登录
    func login(_ sender:ASBaseViewController,withInfo:String,loginSuccess: @escaping (_ str:String) -> Void,loginFail:@escaping () -> Void){
        // sender 是调用这个方法的控制器，
        // 用于提示用户微信支付结果，可以根据自己需求是否要此参数。
        self.sender = sender
        self.loginSuccessClosure = loginSuccess
        self.loginFailClosure = loginFail
//        AlipaySDK.defaultService().auth_V2(withInfo:withInfo, fromScheme:"ciweilive.com", callback:nil)
//        AlipaySDK.defaultService().auth_V2(withInfo: withInfo, fromScheme: "ciweilive.com") { (result) in
//            print("支付宝支付结果\(String(describing: result))")
//        }
    }
    ///授权回调
    func showAuth_V2Result(result:NSDictionary){
        //        9000    请求处理成功
        //        4000    系统异常
        //        6001    用户中途取消
        //        6002    网络连接出错
        let returnCode:String = result["resultStatus"] as! String
        var returnMsg:String = ""
        switch  returnCode{
        case "6001":
            returnMsg = "用户中途取消"
            break
        case "6002":
            returnMsg = "网络连接出错"
            break
        case "4000":
            returnMsg = "系统异常"
            break
        case "9000":
            returnMsg = "授权成功"
            break
        default:
            returnMsg = "系统异常"
            break
        }
        UIAlertController.showAlertYes(title: "授权结果", message: returnMsg, in: sender) { (alert) in
            if returnCode == "9000" {
                let r=result["result"] as! String
                self.loginSuccessClosure?(r)
                
            }else{
                self.loginFailClosure?()
            }
        }
        
    }
    //传入回调参数
    func showResult(result:NSDictionary){
        //        9000    订单支付成功
        //        8000    正在处理中
        //        4000    订单支付失败
        //        6001    用户中途取消
        //        6002    网络连接出错
        let returnCode:String = result["resultStatus"] as! String
        //        var returnMsg:String = ""
        //        switch  returnCode{
        //        case "6001":
        //            returnMsg = "用户中途取消"
        //            break
        //        case "6002":
        //            returnMsg = "网络连接出错"
        //            break
        //        case "8000":
        //            returnMsg = "正在处理中"
        //            break
        //        case "4000":
        //            returnMsg = "订单支付失败"
        //            break
        //        case "9000":
        //            returnMsg = "支付成功"
        //            break
        //        default:
        //            returnMsg = "订单支付失败"
        //            break
        //        }
        //        UIAlertController.showAlertYes(sender, title: "支付结果", message: returnMsg, okButtonTitle:"确定", okHandler: { (alert) in
        //            if returnCode == "9000" {
        //                self.paySuccessClosure?()
        //
        //            }else{
        //                self.payFailClosure?()
        //            }
        //        })
        if returnCode == "9000" {
            self.paySuccessClosure?()
            
        }else{
            self.payFailClosure?()
        }
    }
}
//微信
/*
class WXApiManager:NSObject,WXApiDelegate {
    static let shared = WXApiManager()
    // 用于弹出警报视图，显示成功或失败的信息()
    private weak var sender:SXBaseViewController! //(UIViewController)
    // 支付成功的闭包
    private var paySuccessClosure: (() -> Void)?
    // 支付失败的闭包
    private var payFailClosure: (() -> Void)?
    //登录成功
    private var loginSuccessClosure:((_ code:String) -> Void)?
    //登录失败
    private var loginFailClosure:(() -> Void)?
    // 外部用这个方法调起微信支付
    func payAlertController(_ sender:SXBaseViewController,
                            request:PayReq,
                            paySuccess: @escaping () -> Void,
                            payFail:@escaping () -> Void) {
        // sender 是调用这个方法的控制器，
        // 用于提示用户微信支付结果，可以根据自己需求是否要此参数。
        self.sender = sender
        self.paySuccessClosure = paySuccess
        self.payFailClosure = payFail
        if checkWXInstallAndSupport(){//检查用户是否安装微信
            WXApi.send(request)
        }
    }
    //外部用这个方法调起微信登录
    func login(_ sender:SXBaseViewController,loginSuccess: @escaping ( _ code:String) -> Void,
               loginFail:@escaping () -> Void){
        // sender 是调用这个方法的控制器，
        // 用于提示用户微信支付结果，可以根据自己需求是否要此参数。
        self.sender = sender
        self.loginSuccessClosure = loginSuccess
        self.loginFailClosure = loginFail
        if checkWXInstallAndSupport(){
            let req=SendAuthReq()
            req.scope="snsapi_userinfo"
            req.state="app"
            WXApi.send(req)
        }
    }
    
   
    
}
extension WXApiManager {
    func onResp(_ resp: BaseResp!) {
        if resp is PayResp {//支付
            if resp.errCode == 0 {
                self.paySuccessClosure?()
            }else{
                self.payFailClosure?()
            }
        }else if resp is SendAuthResp{//登录结果
            let authResp = resp as! SendAuthResp
            var strMsg: String
            if authResp.errCode == 0{
                strMsg="微信授权成功"
            }else{
                switch authResp.errCode{
                case -4:
                    strMsg="您拒绝使用微信登录"
                    break
                case -2:
                    strMsg="您取消了微信登录"
                    break
                default:
                    strMsg="微信登录失败"
                    break
                }
            }

            
            UIAlertController.showAlertYes(title: "授权结果", message: strMsg, in: sender) { (alert) in
                if authResp.errCode == 0 {
                    self.loginSuccessClosure?(authResp.code)
                    
                }else{
                    self.loginFailClosure?()
                }
            }
        }else if resp is SendMessageToWXResp{
            if resp.errCode == 0 {
             UIAlertView.quickTip(message:"",title:"分享成功",cancelButtonTitle: "确定")
            }else{
                UIAlertView.quickTip(message:"",title:"分享失败",cancelButtonTitle: "确定")
            }
        }
    }
}

extension WXApiManager {
    // 检查用户是否已经安装微信并且有支付功能
    private func checkWXInstallAndSupport() -> Bool {
        
        if !WXApi.isWXAppInstalled() {
            ///这里的弹窗是我写的扩展方法
            UIAlertController.showAlert(message: "微信未安装")
            
           
            
//            UIAlertController.showAlertYes(sender,title:"", message: "微信未安装", okButtonTitle:"确定")
            return false
        }
        
        if !WXApi.isWXAppSupport() {
            ///这里的弹窗是我写的扩展方法
             UIAlertController.showAlert(message: "当前微信版本不支持支付")
//            UIAlertController.showAlertYes(sender,title:"", message: "当前微信版本不支持支付", okButtonTitle:"确定")
            return false
        }
        return true
    }
}
*/
