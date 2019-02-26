//
//  ASBaseNavController.swift
//  appstore
//
//  Created by   on 2019/1/26.
//  Copyright © 2019 st. All rights reserved.
//

import UIKit

class ASBaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏默认的 NavigationBar
        navigationBar.isHidden = true
    }
    
    /// 重写 push 方法，所有的 push 动作都会调用此方法！
    /// viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器的类型
            if let vc = viewController as? ASBaseViewController {
                
                //                var title = "返回"
                
                // 判断控制器的级数，只有一个子控制器的时候，显示栈底控制器的标题
                if childViewControllers.count == 1 {
                    // title 显示首页的标题
                    //                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // 取出自定义的 navItem，设置左侧按钮作为返回按钮
                let btn1=UIButton.init(type: .custom)
                btn1.frame = CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: 25 , height: 40)
                
                btn1.setImage(UIImage.init(named: "register_icon_back_default"), for: .normal)
                //                btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 10 / ScrenScaleWidth, 0, 0);
                btn1.addTarget(self, action: #selector(popToParent), for: .touchUpInside)
                //                btn1.contentHorizontalAlignment = .left;
                let rightItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                rightItem.width = -10 * SSWid
                
                
                
                
                
                let item=UIBarButtonItem(customView: btn1)
                vc.navItem.leftBarButtonItems = [rightItem,item]
                
                
                
                
            }else{
                //                viewController.hidesBottomBarWhenPushed = false
                navigationBar.isHidden = false
                viewController.navigationController?.isNavigationBarHidden = false
            }
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    /// POP 返回到上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }

}
