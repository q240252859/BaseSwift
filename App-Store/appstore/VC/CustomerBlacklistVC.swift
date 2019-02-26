//
//  CustomerBlacklistVC.swift
//  chezhijia
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit


class CustomerBlacklistVC: ASBaseViewController {

    let table : UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        
        return table
    }()
    
    var ScreenParams:[String:Any] = [:]
    
    
    var dataArr :CustomerBlacklistModel = CustomerBlacklistModel.init()
    var dataSle = 0
    var page = 1
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGetData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navItem.title = "黑名单"
        
        setnavigLeRi()
        self.setUI()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    func setnavigLeRi(){
        
        
        let btn2=UIButton.init(type: .custom)
        btn2.frame = CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: 25 , height: 40)
        btn2.setImage(UIImage.init(named: "ZS加号 (1)"), for: .normal)
        btn2.addTarget(self, action: #selector(popToZSParent), for: .touchUpInside)
        btn2.contentHorizontalAlignment = .left;
        
        let btn=UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: 25 , height: 40)
        btn.setImage(UIImage.init(named: "筛选 (2)"), for: .normal)
        btn.addTarget(self, action: #selector(popTobtn), for: .touchUpInside)
        //        btn.contentHorizontalAlignment = .left;
        
        
        navItem.rightBarButtonItems = [UIBarButtonItem(customView: btn2),UIBarButtonItem(customView: btn)]
        
        
    }
    @objc func popTobtn(){
        let VC = CustomerScreenVC()
        VC.delegate = self
        VC.ScreenParams = ScreenParams
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @objc func popToZSParent(){
//       let VC = CustomerBlackEitdVC()
//        VC.navItem.title = "新增黑名单"
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func setUI(){
        self.view.addSubview(table)
        table.backgroundColor = HedgeColor242
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(CustomerBlacklistTableViewCell.self, forCellReuseIdentifier: "TasteID")
        
        table.easy.layout(
            Top(NAVIGATION_BAR_HEIGHT),
            Right(0),Left(0),Bottom(TAB_BAR_HEIGHT)
        )
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            
        }
        self.table.mj_header = header
        self.table.mj_footer = footer
        footer.setTitle("已经到底了～", for: MJRefreshState.noMoreData)
        
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        // Do any additional setup after loading the view.
    }
    // 顶部刷新
    @objc func headerRefresh(){
        page = 1
        self.setGetData()
        
    }
    
    // 底部刷新
    @objc func footerRefresh(){
        page += 1
        self.setGetData()
        
        
    }
    func setGetData(){
        var params :[String:Any] = ["limit":"10","page":"\(page)"]
        
        for (key, value) in (ScreenParams){
            params[key] = value as Any?
        }
        if let decoded = UserDefaults.standard.value(forKey: UserInfoKey){
            let person = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! UserInfoModel
            params["userId"] = person.user.id
        }
      
        SVProgressHUD.show()
        HedgehogProvider.request(.playlist(params,.post,ApiBlackListsFindBlackListByCondition,URLEncoding.default)){[weak self] result in
            SVProgressHUD.dismiss()
            
            if let strongSelf = self {
                strongSelf.header.endRefreshing()
                strongSelf.footer.endRefreshing()
                if case let .success(response) = result {
                    //解析数据
                    let jsonValue = try? response.mapJSON()
                    let data:Dictionary<String,Any> = jsonValue as? Dictionary ?? ["code":"400","msg":"数据错误"]
                    let isModel:CustomerBlacklistModel =  JSONDeserializer.deserializeFrom(dict: data)!
                    if isModel.code == "0"||isModel.code == "200"{
                    if strongSelf.page == 1{
                        strongSelf.dataArr = isModel
                    }else{
                        strongSelf.dataArr.data+=isModel.data
                    }
                    if  isModel.data.count == 0{
                        strongSelf.footer.endRefreshingWithNoMoreData()
                    }
                    strongSelf.table.reloadData()
                    }else{
                        SVProgressHUD.showError(withStatus: isModel.msg)
                    }
                }else{
                    SVProgressHUD.showError(withStatus: "网络错误")
                }
            
        }
        
      
    }
    
    
    
}
}
extension CustomerBlacklistVC:UITableViewDelegate,UITableViewDataSource{
    //设置cell的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    //设置section的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArr.data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 125
        
        
    }
    //设置tableview的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = dataArr.data[indexPath.section]
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TasteID", for: indexPath)) as! CustomerBlacklistTableViewCell
        cell.selectionStyle = .none;
        cell.backgroundColor = HedgeColor242
        
        cell.indexPath = indexPath
        cell.delegate = self
        cell.titLabel.text = model.name
        cell.conL.text = model.phone
        cell.BottomL.text = "身份证："+model.idCard
        
        
        return cell
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 8
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
        let view = UIView.init()
        view.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 8)
        view.backgroundColor = HedgeColor242
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        //        view.frame = CGRect(x:0, y:0, width:ScreenWidth, height:15)
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        dataSle = indexPath.section
//        let VC = CustomerBlackDetaVC()
//        let model = dataArr.data[indexPath.section]
//        VC.model = model
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
}
extension CustomerBlacklistVC:CustomerBlacklistDelegate{

    func didMoreAt(index: Int, indexPath: IndexPath) {
        let model = self.dataArr.data[indexPath.section]
        if index == 2{
//           let VC = CustomerBlackEitdVC()
//            VC.model = model
//            VC.navItem.title = "编辑"
//            self.navigationController?.pushViewController(VC, animated: true)
        }else if index == 1{

            let alertController = UIAlertController(title: "确定删除", message: model.name, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                let params = ["id":model.id]
                print(self.dataArr.data[indexPath.section].id)
//                self.setDataApi(params: params, method: .delete, Url: ApiBlackLists+"/"+self.dataArr.data[indexPath.section].id, Encoding: URLEncoding.default,"") { [weak self](result) in
//                    if let strongSelf = self {
//                        let isModel:QueryModelsModel =  JSONDeserializer.deserializeFrom(dict: result)!
                        self.dataArr.data.remove(at: indexPath.section)
                        self.table.reloadData()
                        SVProgressHUD.showInfo(withStatus:"删除成功")

//                    }
//                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)

        }else{
//            self.navigationController?.pushViewController(CustomerBlackEitdVC(), animated: true)
        }
    }
}

extension CustomerBlacklistVC:CustomerScreenDelegate,ScreenViewDelegate{
    func ScreenViewDidIndex(_ type: [String : Any]) {

        self.CustomerScreendidMoreAt(index: type)
    }

    func CustomerScreendidMoreAt(index: [String : Any]) {

        let ScrV = ScreenView()
        ScrV.backgroundColor = HedgeColor242
        ScrV.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        ScrV.delegeate = self
        let clientName = index["clientName"] as? String ?? ""
        let phone = index["phone"] as? String ?? ""
        let createTimeMin = index["createTimeMin"] as? String ?? ""
        let createTimeMax = index["createTimeMax"] as? String ?? ""


        ScrV.ScreenParams = index

        if clientName.count > 0||phone.count > 0||createTimeMin.count > 0||createTimeMax.count > 0{
            table.tableHeaderView = ScrV
        }else{
            let viewH = UIView.init()
            viewH.frame = CGRect.init(x: 0, y: 0, width: 0, height: 1)
            table.tableHeaderView = viewH
        }
        ScreenParams = index
        table.mj_header.beginRefreshing()


    }


}
