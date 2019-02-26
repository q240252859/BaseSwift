//
//  MyTextField.swift
//  chezhijia
//
//  Created by mac on 2019/1/8.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class MyTextField: UITextField,UITextFieldDelegate {
    private var maxLength=11
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        self.delegate=self
        
    }
    required init?(coder aDecoder:NSCoder)
    {
        super.init(coder: aDecoder)
        self.delegate=self
        
    }
    //监听输入值的变化
    func textField(_ textField:UITextField, shouldChangeCharactersIn range:NSRange, replacementString string:String) ->Bool{
        let newText = NSString(string:textField.text!).replacingCharacters(in: range, with: string)
        //控制输入长度
        if(newText.characters.count)>maxLength{
            let idx = self.text?.index((text?.startIndex)!, offsetBy:maxLength)
            self.text=self.text?.substring(to: idx!)
            return false}
        //处理明文密文切换时输入不被清空（关键代码）
        if textField==self&&self.isSecureTextEntry{
            self.text = newText
            return false
            
        }
        return true
        
    }//设置可输入的最大长度
    func setMaxLength(maxLength:Int)
    {
        self.maxLength=maxLength
        
    }
    
    
}
