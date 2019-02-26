//
//  ASBaseViewController.swift
//  appstore
//
//  Created by   on 2019/1/26.
//  Copyright © 2019 st. All rights reserved.
//

import UIKit

class ASBaseViewController: UIViewController {

    
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    
    lazy var largeTitleView: ASLargeTitleView = {
        
        let largeTitleView = ASLargeTitleView(frame: CGRect(x: 0, y: 0, width: Int(screenWidth), height: Int(NAVIGATION_BAR_HEIGHT)))
        return largeTitleView
        
    }()
    
    lazy var largeSearchView: ASLargeSearchView = {
        
        let largeSearchView = ASLargeSearchView(frame: CGRect(x: 0, y: 0, width: Int(screenWidth), height: 100))
    
        return largeSearchView
        
    }()
    
    lazy var tableV: UITableView = {
        
        let tableV = UITableView(frame: CGRect(x: 0, y: CGFloat(NAVIGATION_BAR_HEIGHT), width: screenWidth, height: screenHeight - CGFloat(NAVIGATION_BAR_HEIGHT)), style: .plain)
        tableV.tableFooterView = UIView()
        return tableV
        
    }()
    
    /// 自定义导航条
    lazy var navigationBar = SecondNavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: CGFloat(NAVIGATION_BAR_HEIGHT)))
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    lazy var navItem = UINavigationItem()
    
    let btnNa=UIButton.init(type: .custom)
    func LeftDims(){
        //        if self.childViewControllers.count > 0{
        btnNa.frame = CGRect.init(x: 0, y: CGFloat(STATUS_BAR_HEIGHT), width: 40 , height: 40)
        
        btnNa.setImage(UIImage.init(named: "register_icon_back_default"), for: .normal)
        //                btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 10 / ScrenScaleWidth, 0, 0);
        btnNa.addTarget(self, action: #selector(popToNaBtn), for: .touchUpInside)
        btnNa.contentHorizontalAlignment = .left;
        let rightItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightItem.width = -10 * SSWid
        //                self.navigationItem.rightBarButtonItems = [rightItem,UIBarButtonItem(customView: btnRight)]
        
        
        
        
        let item=UIBarButtonItem(customView: btnNa)
        self.navItem.leftBarButtonItems = [rightItem,item]
        
        //        }
    }
    @objc private func popToNaBtn() {
        self.navigationController?.popViewController(animated: true)
        
        guard let nav = self.presentingViewController as? UINavigationController else {
            dismiss(animated: false) {}
            return
        }
        dismiss(animated: false)
        
        
    }
    /// 重写 title 的 didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将 item 设置给 bar
        navigationBar.items = [navItem]
        
        // 1> 设置 navBar 整个背景的渲染颜色
        navigationBar.barTintColor = HedColorWhite
        //        // 2> 设置 navBar 的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: HedgColor21.withAlphaComponent(1),NSAttributedStringKey.font:HedgeSysFont18]
        //        // 3> 设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orange
        
        
        print(self.childViewControllers.count)
        
        
        
        
        
        //状态栏
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: false)
        //        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
    }
    private func setupUI() {
        view.backgroundColor = HedColorWhite
        
        
        
        setupNavigationBar()
        // 取消自动缩进 - 如果隐藏了导航栏，会缩进 20 个点
        extendedLayoutIncludesOpaqueBars = true;
        edgesForExtendedLayout = .top;
        automaticallyAdjustsScrollViewInsets = false;
        
        
        //        WBNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc func login() {
        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NTESNotificationLogout), object: nil)
        
    }
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension ASBaseViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.isEqual(self.tableV) {
//            print("DidScroll:=======\(scrollView.contentOffset.y)")
            
            let offsetY = scrollView.contentOffset.y
            
            if offsetY > 0 {
                navigationController?.navigationBar.isHidden = false
            } else {
                navigationController?.navigationBar.isHidden = true
            }
            
        }

    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("WillBeginDragging:=======\(scrollView.contentOffset.y)")
    }
}

class SecondNavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            //            print("--------- \(stringFromClass)")
            if stringFromClass.contains("BarBackground") {
                subview.frame = self.bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: screenWidth, height: 44)
            }
        }
    }
}
