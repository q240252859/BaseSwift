//
//  AppDelegate.swift
//  appstore
//
//  Created by  on 2019/1/16.
//  Copyright © 2019 st. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        
        if let decoded = UserDefaults.standard.value(forKey: UserInfoKey){
        
            self.window?.rootViewController =  ASTabBarViewController()
        }else{
            self.window?.rootViewController =  UINavigationController.init(rootViewController: SignInVC())
        }
        window?.makeKeyAndVisible()
        
        return true
    }

}

