//
//  UIApplication+AppBaseKit.swift
//  Pods
//
//  Created by zixun on 16/9/25.
//
//

import Foundation
import UIKit


// MARK: - MainWindow
extension UIApplication {
    
    public func mainWindow() -> UIWindow? {
        guard let delegate = self.delegate else {
            return self.keyWindow
        }
        
        guard delegate.responds(to: #selector(getter: UIApplicationDelegate.window)) else {
            return self.keyWindow
        }
        
        return delegate.window!
    }
}

extension Array where Element:NSCopying{
    ///返回元素支持拷贝数组的深拷贝
    public var copy:[Element]{
        return self.map {$0.copy(with: nil) as! Element}
    }
}


