//
//  Common.swift
//  shengxian
//
//  Created by mac on 2018/10/11.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation

// MARK: - 应用程序信息
/// 应用程序 ID
let SXAppKey = "2330725072"
/// 应用程序加密信息(开发者可以申请修改)
let SXAppSecret = "792a4d621dd18003f6e7d47f58c19fa1"
/// 回调地址 - 登录完成调转的 URL，参数以 get 形式拼接
let SXRedirectURI = "http://baidu.com"


let NTESNotificationLogout = "NTESNotificationLogout"

// MARK: - 全局通知定义
/// 用户需要登录通知
let SXUserShouldLoginNotification = "SXUserShouldLoginNotification"
/// 用户登录成功通知
let SXUserLoginSuccessedNotification = "SXUserLoginSuccessedNotification"

// MARK: - 照片浏览通知定义
/// @param selectedIndex    选中照片索引
/// @param urls             浏览照片 URL 字符串数组
/// @param parentImageViews 父视图的图像视图数组，用户展现和解除转场动画参照
/// 微博 Cell 浏览照片通知
let SXStatusCellBrowserPhotoNotification = "SXStatusCellBrowserPhotoNotification"
/// 选中索引 Key
let SXStatusCellBrowserPhotoSelectedIndexKey = "SXStatusCellBrowserPhotoSelectedIndexKey"
/// 浏览照片 URL 字符串 Key
let SXStatusCellBrowserPhotoURLsKey = "SXStatusCellBrowserPhotoURLsKey"
/// 父视图的图像视图数组 Key
let SXStatusCellBrowserPhotoImageViewsKey = "SXStatusCellBrowserPhotoImageViewsKey"

// MARK: - 微博配图视图常量
// 配图视图外侧的间距
let SXStatusPictureViewOutterMargin = 12
// 配图视图内部图像视图的间距
let SXStatusPictureViewInnerMargin = 3
// 视图的宽度的宽度
//let SXStatusPictureViewWidth = ScreenWidth - 2 * SXStatusPictureViewOutterMargin
//// 每个 Item 默认的宽度
//let SXStatusPictureItemWidth = (SXStatusPictureViewWidth - 2 * SXStatusPictureViewInnerMargin) / 3
//用户名
let UserAccountNameKey = "UserAccountNameKey"
//账号登录历史保存
let UserAccountKey = "UserAccountKey"

//极光推送设备标识
let registration_id = "registration_id"


//账号资料
let UserNameKey = "UserNameKey"

//用户信息
let UserInfoKey = "UserInfoKey"

//用户信息
let UserPhoneKey = "UserPhoneKey"


//版本信息
let AppManagementByPNKey = "AppManagementByPNKey"
