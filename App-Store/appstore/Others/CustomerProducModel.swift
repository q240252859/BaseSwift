//
//  CustomerProducModel.swift
//  chezhijia
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
 

class  CustomerProducModel: NSObject, HandyJSON, NSCoding{
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
    @objc var count:String = ""
    @objc var paegs:String = ""
    @objc var data :[CustomerProducDataModel] = []
}
class  CustomerProducDataModel: NSObject, HandyJSON, NSCoding{
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
    @objc var clientId :String = ""
    @objc var productType:String = ""
    @objc var productTypeVal :String = ""
    @objc var brandId:String = ""
    @objc var brandIdVal :String = ""
    
    @objc var seriesId :String = ""
    @objc var seriesIdVal :String = ""
    @objc var modelId:String = ""
    @objc var modelIdVal :String = ""
    @objc var guidePrice :String = ""
    
    @objc var cooperatorId :String = ""
    @objc var cooperatorIdVal :String = ""
    @objc var cooperatorProductId:String = ""
    @objc var cooperatorProductVal :String = ""
    @objc var ticket:String = ""
    @objc var ticketVal :String = ""
    
    @objc var paymentRate :String = ""
    @objc var paymentRateVal :String = ""
    @objc var monthlyInterestRate:String = ""
    @objc var monthlyInterestRateVal :String = ""
    @objc var periods :String = ""
    
    
    @objc var periodsVal :String = ""
    @objc var insurance :String = ""
    @objc var insuranceVal:String = ""
    @objc var purchaseTax :String = ""
    @objc var purchaseTaxVal:String = ""
    @objc var gps :String = ""
    
    @objc var gpsVal :String = ""
    @objc var appliedAmount :String = ""
    @objc var appliedAmountVal:String = ""
    @objc var monthlyInstallmentPayment :String = ""
    @objc var monthlyInstallmentPaymentVal :String = ""
    
    @objc var isHighest :String = ""
    @objc var remake :String = ""
    @objc var businessId:String = ""
    @objc var approvalAmount :String = ""
    @objc var approvalAmountVal:String = ""
    @objc var arrivalAmount :String = ""
    @objc var other :String = ""
    
    @objc var arrivalAmountVal :String = ""
    
    
    
    @objc var dealerName :String = ""
    @objc var idCard :String = ""
    
    @objc var companyAddress :String = ""
    @objc var color :String = ""
    @objc var num:String = ""
    @objc var matEndowmentMoney :String = ""
    @objc var earnest:String = ""
    @objc var trailerMoney :String = ""
    @objc var balanceDueDate :String = ""
    
    @objc var registrationCity :String = ""
    
    
    
}


class  ApplicationProgramSeleModel: NSObject, HandyJSON, NSCoding{
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
    @objc var count:String = ""
    @objc var paegs:String = ""
    @objc var data :[ApplicationProgramSeleDataModel] = []
}
class  ApplicationProgramSeleDataModel: NSObject, HandyJSON, NSCoding{
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
    
    
    @objc var accountHolder :String = ""
    @objc var address :String = ""
    @objc var bankingAccount:String = ""
    @objc var bankingName :String = ""
    @objc var belongsOrganization:String = ""
    @objc var belongsOrganizationVal :String = ""
    
    @objc var businessPolicy :String = ""
    @objc var contacts :String = ""
    @objc var cooperator:String = ""
    @objc var createId :String = ""
    @objc var createName :String = ""
    
    @objc var createTime :String = ""
    @objc var creditLine :String = ""
    @objc var gps:String = ""
    @objc var id :String = ""
    @objc var isSign:String = ""
    @objc var level :String = ""
    
    @objc var levelVal :String = ""
    @objc var other :String = ""
    @objc var overdueDays:String = ""
    @objc var phone :String = ""
    @objc var storeName :String = ""
    
    
    @objc var storeType :String = ""
    @objc var storeTypeVal :String = ""
    @objc var updateId:String = ""
    @objc var updateTime :String = ""
   
}

class  ApplicationProgramSeleOneModel: NSObject, HandyJSON, NSCoding{
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
    @objc var count:String = ""
    @objc var paegs:String = ""
    @objc var data :[ApplicationProgramSeleOneDataModel] = []
}
class  ApplicationProgramSeleOneDataModel: NSObject, HandyJSON, NSCoding{
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
    
    
    @objc var cooperateId :String = ""
    @objc var createId :String = ""
    @objc var createName:String = ""
    @objc var createTime :String = ""
    @objc var id:String = ""
    @objc var isDelete :String = ""
    
    @objc var name :String = ""
    @objc var number :String = ""
    @objc var productTypeId:String = ""
    @objc var productTypeIdVal :String = ""
    @objc var remarks :String = ""
    
    @objc var updateId :String = ""
    @objc var updateTime :String = ""
    
    
}

class  CustomerBlacklistModel: NSObject, HandyJSON, NSCoding{
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
    @objc var count:String = ""
    @objc var paegs:String = ""
    @objc var data :[CustomerBlacklistDataModel] = []
}
class CustomerBlacklistDataModel: NSObject, HandyJSON, NSCoding{
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
    @objc var name :String = ""
    @objc var phone:String = ""
    @objc var remarks :String = ""
    @objc var idCard:String = ""
    
}

