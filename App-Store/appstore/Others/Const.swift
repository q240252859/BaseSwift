
//
//  Const.swift
//  appstore
//
//  Created by   on 2019/1/26.
//  Copyright © 2019 st. All rights reserved.
//

import UIKit
//pch
@_exported import MJRefresh
@_exported import EasyPeasy
@_exported import HandyJSON
@_exported import SVProgressHUD
@_exported import Alamofire
@_exported import Moya
@_exported import MJExtension


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

public func ColorRGB(_ r: Int, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
}

public func ColorRGB_(_ v: Int) -> UIColor {
    return UIColor.init(red: CGFloat(v)/255.0, green: CGFloat(v)/255.0, blue: CGFloat(v)/255.0, alpha: 1)
}

let SSHei = UIScreen.main.bounds.size.height/667.0
let SSWid = UIScreen.main.bounds.size.width/375.0



//系统
let HedgeSysFont25 = UIFont.systemFont(ofSize: 25*SSWid)
let HedgeSysFont18 = UIFont.systemFont(ofSize: 18*SSWid)
let HedgeSysFont12 = UIFont.systemFont(ofSize: 12*SSWid)
let HedgeSysFont13 = UIFont.systemFont(ofSize: 13*SSWid)
let HedgeSysFont11 = UIFont.systemFont(ofSize: 11*SSWid)
let HedgeSysFont15 = UIFont.systemFont(ofSize: 15*SSWid)
let HedgeSysFont14 = UIFont.systemFont(ofSize: 14*SSWid)

//加粗
let HedgeBoldFont24 = UIFont.boldSystemFont(ofSize: 24*SSWid)

//Medium 字体
let HedMediumFont10 = UIFont.init(name: "PingFang-SC-Medium", size: 10*SSWid)
let HedMediumFont12 = UIFont.init(name: "PingFang-SC-Medium", size: 12*SSWid)
let HedMediumFont16 = UIFont.init(name: "PingFang-SC-Medium", size: 16*SSWid)
//需要下载字体 PangMenZhengDao文件 在Assets 图片文件夹
let HedgePangMenZhengDaoFont12 = UIFont(name: "PangMenZhengDao", size: 24) ?? HedgeBoldFont24

let HedgColor21 = ColorRGB(21, 70, 199)
let HedgColor25 = ColorRGB_(25)
let HedgColor51 = ColorRGB_(51)
let HedgColor153 = ColorRGB_(153)
let HedgColor239 = ColorRGB_(239)
let HedgeColor242 = ColorRGB_(242)
let HedgColor139 = ColorRGB(255, 139, 26)
let HedgColor248 = ColorRGB(248, 175, 79)

let HedColorWhite = UIColor.white
let HedColorBlack = UIColor.black
let commonColor = UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1)
let lineColor = UIColor(red: 218.0 / 255.0, green: 218.0 / 255.0, blue: 218.0  / 255.0, alpha: 1)
let blueColor = UIColor(red: 3.0 / 255.0, green: 115.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
let randomColor = UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
//let isIPhoneX = UIScreen.main.bounds.size.equalTo(CGSize (width: 375, height: 812))
//let navigationBarHeight:CGFloat = isIPhoneX ? 88 : 64
//let bottomToolBarHeight:CGFloat = isIPhoneX ? 80 : 49

//适配Iphone_X XR XS XSMax
let Is_Iphone = (UI_USER_INTERFACE_IDIOM() == .phone)

let Is_Iphone_X_XS_XR_XSMAX  = (Is_Iphone &&  screenHeight >= 812)
// 状态栏高度
let STATUS_BAR_HEIGHT : CGFloat = Is_Iphone_X_XS_XR_XSMAX ? 44 : 20
// 导航栏高度
let NAVIGATION_BAR_HEIGHT : CGFloat = Is_Iphone_X_XS_XR_XSMAX ? 88 : 64
// tabBar高度
let TAB_BAR_HEIGHT : CGFloat = Is_Iphone_X_XS_XR_XSMAX ? 49 + 34 : 49
// home indicator
let HOME_INDICATOR_HEIGHT : CGFloat = Is_Iphone_X_XS_XR_XSMAX ? 34 : 0
