//
//  SignInModel.swift
//  chezhijia
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
 
class  SignInModel: NSObject, HandyJSON,NSCoding {
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
    
   @objc var scope :String = ""
   @objc var token_type :String = ""
   @objc var expires_in:String = ""
   @objc var refresh_token :String = ""
   @objc var access_token :String = ""
   @objc var code:String = ""
   @objc var message:String = ""
}
