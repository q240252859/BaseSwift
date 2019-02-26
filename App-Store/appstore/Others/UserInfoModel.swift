//
//  UserInfoModel.swift
//  chezhijia
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import HandyJSON
import MJExtension
class  UserInfoModel: NSObject, HandyJSON, NSCoding{
    //父类的init方法是必须去实现的
    override required init() {
        super.init()
    }
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.mj_decode(aDecoder)
    }
    
    func encode(with aCoder: NSCoder) {
        self.mj_encode(aCoder)
    }
    
    @objc var msg :String = ""
    @objc var code :String = ""
    @objc var user:UserModels = UserModels.init()
    @objc var token :String = ""
    @objc var status :String = ""
    
}

class UserModels: NSObject, HandyJSON, NSCoding{
    //父类的init方法是必须去实现的
    override required init() {
        super.init()
    }
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.mj_decode(aDecoder)
    }
    
    func encode(with aCoder: NSCoder) {
        self.mj_encode(aCoder)
    }
    
    @objc  var id :String = ""
    
    @objc  var employeeName  :String = ""
    @objc  var phone  :String = ""
    @objc  var imAccid  :String = ""
    
    @objc  var imToken  :String = ""
    @objc  var identityCard  :String = ""
    
    @objc  var gender :String = ""
    @objc var genderVal :String = ""
    @objc  var maritalStatus  :String = ""
    @objc  var maritalStatusVal :String = ""
    @objc  var jobNo :String = ""
    @objc  var accountNo  :String = ""
    @objc  var nativePlace :String = ""
    @objc   var nation :String = ""
    @objc   var qq  :String = ""
    @objc  var positionId  :String = ""
    
    @objc  var positionIdVal :String = ""
    @objc  var hiredate  :String = ""
    
    @objc var positiveTime  :String = ""
    @objc  var address :String = ""
    @objc  var contactNum:String = ""
    
    @objc  var emergencyContact :String = ""
    
    @objc  var emergencyPhone:String = ""
    @objc  var isCooperator :String = ""
    @objc  var cooperator :String = ""
    @objc  var level :String = ""
    @objc var levelVal  :String = ""
    @objc   var lineOfCredit:String = ""
    @objc  var icon :String = ""{
        didSet{
            if icon == ""{
                icon = "https://www.baidu.com/"
            }
            
        }
    }
    @objc  var storeAudit :String = ""
    @objc  var createrId :String = ""
    @objc  var createTime :String = ""
    @objc  var updaterId :String = ""
    @objc  var updateTime :String = ""
    @objc  var enabled :[String] = []
    @objc  var organizationId  :String = ""
    @objc   var organizationIdVal :String = ""
    @objc   var password:String = ""
    @objc  var leaveStatus:String = ""
    @objc  var judge :String = ""
    @objc  var storeId :String = ""
    
    
    @objc  var username:String = ""
    @objc  var accountNonExpired:String = ""
    @objc var accountNonLocked:String = ""
    
    @objc var credentialsNonExpired :String = ""
    @objc  var email :String = ""
    
    @objc  var sysRoles :[sysRolesModel] = []
    
}

class  sysRolesModel: NSObject, HandyJSON, NSCoding{
    //父类的init方法是必须去实现的
    override required init() {
        super.init()
    }
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.mj_decode(aDecoder)
    }
    
    func encode(with aCoder: NSCoder) {
        self.mj_encode(aCoder)
    }
    
    @objc var id :String = ""
    @objc  var name :String = ""
    //    var description :String = ""
    
    @objc   var createrId :String = ""{
        didSet {
            
        }
    }
    
    @objc  var createTime :String = ""
    @objc  var updaterId :String = ""
    
    @objc  var updateTime :String = ""
    @objc   var isDelete :String = ""
    @objc  var code :String = ""
    
    
    
}
