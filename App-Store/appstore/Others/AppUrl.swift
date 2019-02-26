//
//  AppUrl.swift
//  EFarmSwift
//
//  Created by  on 2017/8/29.
//  Copyright © 2017年  . All rights reserved.
//

import UIKit

//let BaseUrl = "http://192.168.0.97:8090"
//let BaseUrl = "http://192.168.0.97:8088"
//let BaseUrl = "http://192.168.0.47:8090"

//let BaseUrl = "http://192.168.0.38:8088"
//let BaseUrl = "http://192.168.0.43:8090"
//let BaseUrl = "http://192.168.0.43:8088"
let BaseUrl = "http://api.chezhijia100.com"

//图片服务器
let qiniuyunUrl = "http://file.chezhijia100.com/"



//POST /api/blackLists/findBlackListByCondition 条件查询黑名单(不传条件则查询所有)
let ApiBlackListsFindBlackListByCondition = "/api/blackLists/findBlackListByCondition"



//登录获取Token
let OauthTokenURl = "/oauth/token"

//获取用户信息
let UserInfo = "/userInfo"

//POST /api/sms/sendCode 发送验证码
/*
 phone
 (required)
 手机号
 
 query    string
 */
let ApiSmsSendCode = "/api/sms/sendCode"

//POST /api/sms/verify 验证码验证
/*
 phone
 (required)
 手机号
 
 query    string
 code
 (required)
 验证码
 
 query    string
 */
let ApiSmsVerify = "/api/sms/verify"

//POST /api/employees/updatePassword 修改密码---通过旧密码修改
/*
userId
(required)
登陆者id

query    long
newPassword
(required)
新密码

query    string
oldPassword
(required)
旧密码

query    string
*/
let ApiEmployeesUpdatePassword = "/api/employees/updatePassword"

//POST /api/employees/resetPassword 修改密码
/*
 phone
 (required)
 员工手机号码
 
 query    string
 
 password
 (required)
 新密码
 
 query    string
 */
let ApiEmployeesResetPassword = "/api/employees/resetPassword"
