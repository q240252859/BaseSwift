//
//  ASGameViewController.swift
//  appstore
//
//  Created by   on 2019/1/26.
//  Copyright © 2019 st. All rights reserved.
//

import UIKit

class ASUpdateViewController: ASBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUI()
        
    }
    
    fileprivate func setUI() {
        
        self.tableV.delegate = self
        self.tableV.dataSource = self
        self.largeTitleView.isShowTime = false
        self.largeTitleView.isShowBottomLine = true
        self.largeTitleView.headLabel.text = "Update"
        self.tableV.tableHeaderView = self.largeTitleView
        self.tableV.estimatedRowHeight = 100
        self.tableV.rowHeight = UITableViewAutomaticDimension
        self.tableV.register(UINib.init(nibName: "ASUpdateTableViewCell", bundle: nil), forCellReuseIdentifier: "ASUpdateTableViewCell")
        self.tableV.register(UINib.init(nibName: "ASUpdate1TableViewCell", bundle: nil), forCellReuseIdentifier: "ASUpdate1TableViewCell")
        view.addSubview(self.tableV)
        
    }
    
}

extension ASUpdateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ASUpdateTableViewCell") as? ASUpdateTableViewCell
            cell?.updateDes.text = "走过路过，不要错过\n更不了吃亏，更不了上当"
            return cell!
            
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ASUpdate1TableViewCell") as? ASUpdate1TableViewCell
            cell?.updateDes.text = "走过路过，不要错过\n更不了吃亏，更不了上当"
            return cell!
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.AllCommodityRiDid(indexPath.row, type: "")
    }
    
    func updata(){
        //下载 记得设置下载地址 BaseUrl  和 后 "TokenDownloadFile" //默认下载保存地址（用户文档目录）DefaultDownloadDir
        let params:[String:Any] = ["pathList":"abc"]
        MyServiceProvider.request(.playlist(params, .get, "TokenDownloadFile", URLEncoding.default, Date().currentDateIntoString()),progress:{
            progress in
            // 下载进度
            SVProgressHUD.showProgress(Float(progress.progress))
            if Float(progress.progress) >= 1.0{
                SVProgressHUD.dismiss()
            }
            //实时打印出下载进度
            print("当前进度: \(progress.progress)")
        }) {[weak self] result in
            if let strongSelf = self {
                switch result {
                case .success:
                    SVProgressHUD.showSuccess(withStatus: "下载成功")
//                    let VC = NTESFileTransSelectViewController()
//                    VC.seleStr = "查看"
//                    strongSelf.navigationController?.pushViewController(VC, animated: true)
//                    strongSelf.navigationController?.setNavigationBarHidden(false, animated: true)
                case let .failure(error):
                    print(error)
                }
            }
            
        }
        
        /*
         MyServiceProvider.request(.downloadAsset(assetName:model.url, FileName: name),progress:{
         progress in
         //实时打印出下载进度
         SVProgressHUD.showProgress(Float(progress.progress))
         if Float(progress.progress) >= 1.0{
         SVProgressHUD.dismiss()
         }
         print("当前进度: \(progress.progress)")
         }) {[weak self] result in
         if let strongSelf = self {
         switch result {
         case .success:
         SVProgressHUD.showSuccess(withStatus: "下载成功")
         let VC = NTESFileTransSelectViewController()
         VC.seleStr = "查看"
         strongSelf.navigationController?.pushViewController(VC, animated: true)
         strongSelf.navigationController?.setNavigationBarHidden(false, animated: true)
         case let .failure(error):
         print(error)
         }
         }
         
         }
         */
    }
    
    
    func AllCommodityRiDid(_ Indx: Int, type: String) {
        switch Indx {
        case 0:
            let vc = WKWebViewController()
            vc.LeftDims()
            vc.title = "baidu"
            vc.gameUrl = "https://pro.modao.cc/app/8biQooiG8dIrcEMwVoy9urPtqxfYU8X#screen=sFF46A822E71539085204474"
            self.present(vc, animated: true, completion: nil)
        case 1:
            let vc = WKWebViewController()
            vc.title = "baidu"
            vc.gameUrl = "https://www.lymanli.com/"
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = WKWebViewController()
            vc.title = "baidu"
            vc.StrHTML = "<p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/08/01/FsZJ9JbTrIh3ZQ5HyRnCNpqwh5Fw.jpg!730x0.jpg\"/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center; line-height: normal;\"><strong><span style=\"font-size: 14px;\">口红对于你来说意味着什么？</span></strong></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><br/></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: center; line-height: normal;\"><span style=\"border: 0px; margin: 0px; padding: 0px; font-size: 14px;\">“Beauty, to me,&nbsp;</span></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: center; line-height: normal;\"><span style=\"border: 0px; margin: 0px; padding: 0px; font-size: 14px;\">is about being comfortable in your own skin.&nbsp;</span></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: center; line-height: normal;\"><span style=\"font-size: 14px;\"><strong><span style=\"border: 0px; margin: 0px; padding: 0px; color: rgb(49, 133, 155);\">That, or a kick-ass red lipstick.</span></strong><span style=\"border: 0px; margin: 0px; padding: 0px;\">”</span></span></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: center; line-height: normal;\"><span style=\"font-size: 14px;\"><span style=\"border: 0px; margin: 0px; padding: 0px;\">美丽，</span>对于我来说</span></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: center; line-height: normal;\"><span style=\"border: 0px; margin: 0px; padding: 0px; font-size: 14px;\">在于对自己的皮肤的自信；</span></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: center; line-height: normal;\"><span style=\"font-size: 14px;\">或者</span></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: center; line-height: normal;\"><span style=\"font-size: 14px;\"><strong><span style=\"border: 0px; margin: 0px; padding: 0px; color: rgb(49, 133, 155);\">涂一支气场全开的红色口红</span></strong></span></p><p style=\"margin-top: 0.63em; margin-bottom: 1.8em; white-space: normal; border: 0px; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: &quot;PingFang SC&quot;, Arial, 微软雅黑, 宋体, simsun, sans-serif; text-align: right; line-height: normal;\"><span style=\"border: 0px; margin: 0px; padding: 0px; font-size: 14px;\">― Gwyneth Paltrow</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/06/03/1a325dd5770f157bc1e59c3828355eaa.jpg!730x0.jpg\"/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\">相信，很多女生刺猬er（也有可能是男生？）梳妆台上摆满了DIOR、CHANEL、YSL、ESTEE LAUDER等各种斩男色口红。</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\">但是，你有一支独一无二的、亲手制作的新鲜口红吗？</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/08/01/FrFlorSx-BqsAoFRI-9Qti1vqmHN.gif!730x0.jpg\"/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\">热情的八月暑假，刺猬约你赴一场口红手作的下午茶时光～带上你的男盆友或者好闺蜜，一起为自己制作一支代表你颜色的口红吧！</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/08/01/FnL7P7gpTp4H2j2DI8-oYd2IjbZ1.jpg!730x0.jpg\"/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"font-size: 14px;\"><strong><br/></strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"font-size: 14px; color: rgb(255, 255, 255); background-color: rgb(75, 172, 198);\"><strong>&nbsp;体验类型&amp;价格&nbsp;</strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"color: rgb(49, 133, 155); font-size: 14px;\"><strong><br/></strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"font-size: 14px;\"><strong>周末预约场</strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"color: rgb(75, 172, 198); font-size: 14px;\">98&nbsp;元/支</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"font-size: 14px;\"><strong>平日预约场</strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"color: rgb(75, 172, 198); font-size: 14px;\">78&nbsp;元/支</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"color: rgb(75, 172, 198); font-size: 14px;\"><br/></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><span style=\"color: rgb(75, 172, 198); font-size: 14px;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/08/01/FjpkKx4_XFXqKn6eKgUQQf7QJtHn.jpg!730x0.jpg\"/></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\"><strong>课程内容</strong>：参与者可现场调制一只膏体口红<br/></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\"><strong>课程时长</strong>：1-2小时</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\"><strong><span style=\"color: rgb(75, 172, 198);\"><br/></span></strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\"><span style=\"color: rgb(75, 172, 198);\"><strong>提示：本次体验</strong></span><span style=\"font-weight: bold; color: rgb(75, 172, 198);\">不适宜14岁以下儿童。</span></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/06/03/1a325dd5770f157bc1e59c3828355eaa.jpg!730x0.jpg\"/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><span style=\"color: rgb(75, 172, 198);\"><strong>关于地点</strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><span style=\"color: rgb(75, 172, 198);\"><strong><br/></strong></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><span style=\"color: rgb(75, 172, 198);\"><span style=\"caret-color: rgb(75, 172, 198); font-size: 14px; color: rgb(0, 0, 0);\"><strong>刺猬X裁学堂</strong></span></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><span style=\"color: rgb(75, 172, 198);\"><span style=\"caret-color: rgb(75, 172, 198); font-size: 14px; color: rgb(0, 0, 0);\"><strong><br/></strong></span></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><span style=\"color: rgb(75, 172, 198);\"><span style=\"caret-color: rgb(75, 172, 198); font-size: 14px; color: rgb(0, 0, 0);\">(地址：深圳市南山区蛇口街道荔园路9号风火创意社区南区好吃集了二楼集上裁学堂)</span></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><strong><br/></strong></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/08/01/Fje2-izqbYpwe4ne0IAOQgy6UPBB.png!730x0.jpg\"/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box; text-align: center;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><span style=\"font-size: 14px;\">参与过刺猬小黑裙手作体验的刺猬er一定对深圳“裁学堂”不陌生。这次，刺猬再次与裁学堂蛇口教室合作，一起带给大家热情而又文艺的夏天～</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><span style=\"font-size: 14px;\"><br/></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><span style=\"font-size: 14px;\">裁学堂蛇口教室位于深圳G&amp;G风火创意园</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><span style=\"font-size: 14px;\"><br/></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/08/01/Fhy991FOovwviOuhgvJz2YnauGLu.jpeg!730x0.jpg\"/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; padding: 0px; box-sizing: border-box;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\">G&amp;G创意社区是聚焦新生活方式的设计体验中心与产业创意中心，由南星玻璃厂改建而成。是一个有趣而时尚的工业风创意社区～</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\"><img src=\"https://img.yzcdn.cn/upload_files/2018/08/01/Fm4QBAdMKCPNzFIpyPLbB5oH72vL.jpeg!730x0.jpg\"/></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><br/></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\">所以， 选一个阳光明媚的午后，来为自己做一只专属口红吧～</span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal;\"><span style=\"font-size: 14px;\"><br/></span></p><p style=\"font-family: Helvetica, &quot;STHeiti STXihei&quot;, &quot;Microsoft JhengHei&quot;, &quot;Microsoft YaHei&quot;, Tohoma, Arial; white-space: normal; text-align: center;\"><br/></p><p><br/></p>"
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
            
        }
    }
}
