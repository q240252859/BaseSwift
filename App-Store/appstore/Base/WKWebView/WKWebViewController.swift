 //
//  WKWebViewController.swift
//  Pellenc
//
//  Created by 文祥的Mac on 2018/6/20.
//  Copyright © 2018年 mingLuo. All rights reserved.
//

import UIKit
import WebKit
 

class WKWebViewController: ASBaseViewController {
    var webView: WebView = WebView.init()
    
    var Url:String = ""
//    var model:LoginuserModel!
    var gameUrl : String = ""
    
    var StrHTML : String = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var dims = false
    
   
 
//    override func viewWillDisappear(_ animated: Bool) {
//
//        super.viewWillDisappear(true)
//       appDelegate.allowRotation = 0 //1表示支持横竖屏
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        appDelegate.allowRotation = 1 //1表示支持横竖屏
//    }
//    override var shouldAutorotate: Bool{
//        get{
//            return false
//        }
//
//    }
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return self.supportedInterfaceOrientations
//    }
//    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//
//    }
    @objc func sent(but:NSString){
        
    }
    let kAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
//        - (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    return nil;
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        let dict:NSDictionary = NSDictionary(object: UIColor.white,forKey:NSAttributedStringKey.foregroundColor as NSCopying)

        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
        

        
        /// POP 返回到上一级控制器
       
        if dims {
        self.LeftDims()
        }
        
        
        
        
       
        
        
        
        //        HTTPCookieStorage.shared.setCookies([cookie!], for: URL.init(string: BaseUrl+Url), mainDocumentURL: nil)
        
        
        let cookieArray = HTTPCookieStorage.shared.cookies!
        for cookie in cookieArray
        {
            print("name:\(cookie.name),value:\(cookie.value),domain:\(cookie.domain)")
            print("")
        }
       
        
        
        
        
        webView.frame = CGRect.init(x: 0, y:NAVIGATION_BAR_HEIGHT, width:screenWidth  , height: screenHeight-NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT)
        self.view.addSubview(webView)
         webView.delegate = self

        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 配置webView样式
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        
       
        
        // 加载普通URL
//        print(LanguageHelper.getString(key: "select_languageKey"))
  
        
 
        
  
        webView.webConfig = config
        
        
        print(StrHTML)
        
        if StrHTML.isEmpty{
            
            
            if gameUrl.count == 0{
                if Url.count > 4{
//                    webView.webloadType(self, .URLString(url: BaseUrl + "/"+Url))
                }else {
                    webView.webloadType(self, WkwebLoadType.HTMLName(name: ""))
                    webView.webloadType(self, .URLString(url: "http://www.baidu.com/"))
                }
                
            }else{
                
                webView.webloadType(self, .URLString(url: gameUrl))
            }
            
        }else{
        webView.webloadType(self, WkwebLoadType.HTMLString(StrHTML: StrHTML))
           
        }
    }

   

//    @objc  func popToParent() {
//
//
//        self.dismiss(animated: true, completion: nil)
//    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
//    func configNavgationItem() -> Void {}
    
    @objc func backAction() {
//        kAppdelegate?.blockRotation = .portrait
        navigationController?.popViewController(animated: true)
        

    }
    

  
}


extension WKWebViewController:WKWebViewDelegate{
    
    func webViewUserContentController(_ scriptMessageHandlerArray: [String], didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
//        if model != nil {
//
//        let token :String = model.result.token
//        let userName : String = model.result.userName
//       let headUrl : String = model.result.headUrl
//        let id : String = model.result.id
//
//        let postData = "localStorage.setItem('token','\(token)')"
//        let postData1 = "localStorage.setItem('userName','\(userName)')"
//        let postData2 = "localStorage.setItem('headUrl','\(headUrl)')"
//        let postData3 = "localStorage.setItem('id','\(id)')"
//        webView.evaluateJavaScript(postData1) { result,error in
//            print(error ?? "")
//        }
//        webView.evaluateJavaScript(postData) { result,error in
//            print(error ?? "")
//        }
//        webView.evaluateJavaScript(postData2) { result,error in
//            print(error ?? "")
//        }
//        webView.evaluateJavaScript(postData3) { result,error in
//            print(error ?? "")
//            }
//
//        }
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for(var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}"
        
        
        webView.evaluateJavaScript(jScript, completionHandler: nil)
        
        
//        webView.evaluateJavaScript("document.body.offsetHeight", completionHandler: { (result, error) in
//            if error == nil && result != nil{
//                let heigh = result as! CGFloat
//
//                self.webView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: heigh)
//                self.table.tableHeaderView = self.webView
//
//
//            }
//        })
        
    }
    
    
}
//extension AppDelegate{
//
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//
//        return blockRotation
//    }
//}

