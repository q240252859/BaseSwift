//
//  UIView+AppBaseKit.swift
//  Pods
//
//  Created by zixun on 16/9/25.
//
//

import Foundation
import UIKit

extension UIView {
    
    /**
     if view or subviews is first responder, find and resign it
     
     - returns: retun true if find and resign first responder, otherwise return false
     */
    
    public func findAndResignFirstResponder() -> Bool {
        if self.isFirstResponder {
            self.resignFirstResponder()
            return true
        }
        
        for subview in self.subviews {
            if subview.findAndResignFirstResponder() {
                return true
            }
        }
        
        return false
    }
}
public extension UIView {
    //只读属性, 不写set就是只读
    var left : CGFloat {
        get{
            return self.frame.origin.x
        }
        //        set{
        //
        //        }
    }
    //上述方式的简写
    var right : CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    var top : CGFloat {
        return self.frame.origin.y
    }
    
    var bottom : CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    var width : CGFloat {
        return self.frame.size.width
    }
    
    var height : CGFloat {
        return self.frame.size.height
    }
    
}
