//
//  CustomerScreenVC.swift
//  chezhijia
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
protocol CustomerScreenDelegate {
    func CustomerScreendidMoreAt(index:[String:Any])
}
class CustomerScreenVC: ASBaseViewController {

    let table : UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), style: .plain)
        
        return table
    }()
    var delegate:CustomerScreenDelegate?

    var ScreenParams:[String:Any] = [:]{
        didSet{
            
            TFName[0] = ScreenParams["clientName"] as? String ?? ""
            TFName[1] = ScreenParams["phone"] as? String ?? ""
            TFName[2] = ScreenParams["createTimeMin"] as? String ?? ""
            TFName[3] = ScreenParams["createTimeMax"] as? String ?? ""
        }
    }
    
    var dataName = ["客户姓名","客户手机号码","最小创建时间","最大创建时间"]
    var TFName = ["","","",""]
    var datePick = UIDatePicker.init()
    var dateFormatter = DateFormatter()
    var SeleDateindx: IndexPath = IndexPath.init(row: 0, section: 12)
    
    
    
    let BasebackV = UIView.init()
    let BaseLeButton = UIButton.init(type: .custom)
    let BaseRiButton = UIButton.init(type: .custom)
    let BaseBottomV = UIView.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = "筛选"
        
        self.setUI()
        datePick = self.setDatePicker("选择时间")
        BaseRiButton.addTarget(self, action: #selector(BaseRiButt), for: .touchUpInside)
    }

    
    
    func setUI(){
        self.view.addSubview(table)
        table.backgroundColor = HedColorWhite
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(ReimbursementEditTableViewCell.self, forCellReuseIdentifier: "TasteID")
        table.register(DiaryEditVCTableViewCell.self, forCellReuseIdentifier: "DiaryEditID")
        
        table.easy.layout(
            Top(NAVIGATION_BAR_HEIGHT),
            Right(0),Left(0),Bottom(HOME_INDICATOR_HEIGHT)
        )
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            
        }
        
        setnavigLeRi()
        setFooterV()
    }
    
    func setFooterV(){
        let view = UIView.init()
        view.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 60)
        let titB = UIButton.init(type: UIButtonType.custom)
        view.addSubview(titB)
        let titW = "重置".ga_widthForComment(fontSize: HedgeSysFont15)
        titB.easy.layout(CenterY(0),Left(15),Width(titW+31),Height(27))
        titB.setTitleColor(HedgColor248, for: UIControlState.normal)
        titB.setTitle("重置", for: UIControlState.normal)
        titB.titleLabel?.font = HedgeSysFont15
        titB.layer.masksToBounds = true
        titB.layer.cornerRadius = 13.5
        titB.clipsToBounds = true
        titB.layer.borderColor = HedgColor248.cgColor
        titB.layer.borderWidth = 1
        titB.addTarget(self, action: #selector(didRightB(_:)), for: .touchUpInside)
        
        
        table.tableFooterView = view
    }
    
    
    func setnavigLeRi(){
        
        
        let btn2=UIButton.init(type: .custom)
        btn2.frame = CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: 25 , height: 40)
        //        btn2.setImage(UIImage.init(named: "ZS加号 (1)"), for: .normal)
        btn2.setTitle("保存", for: UIControlState.normal)
        btn2.titleLabel?.font = HedgeSysFont18
        btn2.setTitleColor(HedgColor25, for: UIControlState.normal)
        btn2.addTarget(self, action: #selector(popToZSParent), for: .touchUpInside)
        btn2.contentHorizontalAlignment = .left;
        
        navItem.rightBarButtonItem = UIBarButtonItem(customView: btn2)
        
        
    }
    
    @objc func popToZSParent(){
        if delegate != nil{
        self.delegate?.CustomerScreendidMoreAt(index: ["createTimeMin" : TFName[2],"createTimeMax" : TFName[3],"phone" : TFName[1],"clientName" : TFName[0]])
        }
        self.navigationController?.popViewController(animated: true)
    }
    @objc func BaseRiButt(){
        let currentDate = datePick.date
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: currentDate)
        TFName[SeleDateindx.row] = dateStr
        table.reloadData()
    }
    @objc func didRightB(_ button:UIButton){
        TFName = ["","","",""]
        table.reloadData()
    }
}
extension CustomerScreenVC:UITableViewDelegate,UITableViewDataSource{
    //设置cell的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataName.count
        
    }
    
    //设置section的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
        
        
    }
    //设置tableview的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if dataName[indexPath.row].contains("时间"){
            
            let cell = (tableView.dequeueReusableCell(withIdentifier: "DiaryEditID", for: indexPath)) as! DiaryEditVCTableViewCell
            cell.selectionStyle = .none;
            cell.titLabel.text = dataName[indexPath.row]
            cell.conL.text = TFName[indexPath.row]
            
            cell.conL.delegate = self
            cell.conL.tag = 100+indexPath.row
            
            cell.conL.placeholder = "请选择"
            return cell
        }
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TasteID", for: indexPath)) as! ReimbursementEditTableViewCell
        cell.selectionStyle = .none;
        cell.titLabel.text = dataName[indexPath.row]
        cell.conL.text = TFName[indexPath.row]
        
        cell.conL.delegate = self
        cell.conL.tag = 100+indexPath.row
        cell.conL.clearButtonMode = .whileEditing
        cell.conL.placeholder = "请输入"
        if indexPath.row == 1{
            cell.conL.keyboardType = UIKeyboardType.numberPad
        }else{
            cell.conL.keyboardType = UIKeyboardType.`default`
        }
        
        if indexPath.row == dataName.count - 1{
            cell.lin.isHidden = true
        }else{
            cell.lin.isHidden = false
        }
        return cell
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init()
        
        view.backgroundColor = HedgeColor242
        return view
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}

extension CustomerScreenVC:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        if dataName[textField.tag-100].contains("时间"){
            BaseSeleDataHidden()
            SeleDateindx = IndexPath.init(row: textField.tag-100, section: 0)
            datePick.isHidden = false
            return false
        }
       
        
        
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        print(textField.tag)
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        TFName[textField.tag-100] = newText
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        TFName[textField.tag-100] = ""
        return true
        
    }
}

extension CustomerScreenVC{
    func setDatePicker(_ title:String)->UIDatePicker{
        let datePicker = UIDatePicker.init()
        
        self.view.addSubview(BasebackV)
        BasebackV.easy.layout(Top(0),Right(0),Left(0),Bottom(0))
        BasebackV.backgroundColor = HedgColor25.withAlphaComponent(0)
        //        backV.alpha = 0.8
        BasebackV.isHidden = true
        
        
        BasebackV.addSubview(BaseBottomV)
        BaseBottomV.easy.layout(Bottom(0),Right(0),Left(0))
        
        BaseBottomV.backgroundColor = HedColorWhite
        BaseBottomV.addSubview(datePicker)
        
        datePicker.easy.layout(Bottom(STATUS_BAR_HEIGHT),Right(0),Left(0),Height(193))
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        
        
        
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
        
        let picTopV = UIView.init()
        BaseBottomV.addSubview(picTopV)
        picTopV.easy.layout(Bottom(0).to(datePicker,.top),Left(0),Right(0),Height(61))
        picTopV.backgroundColor = HedColorWhite
        
        
        picTopV.addSubview(BaseLeButton)
        picTopV.addSubview(BaseRiButton)
        BaseLeButton.easy.layout(Left(0),Top(0),Bottom(0),Width(30+"取消".ga_widthForComment(fontSize: HedgeSysFont14)))
        BaseRiButton.easy.layout(Right(0),Top(0),Bottom(0),Width(30+"确定".ga_widthForComment(fontSize: HedgeSysFont14)))
        BaseLeButton.setTitle("取消", for: .normal)
        BaseRiButton.setTitle("确定", for: .normal)
        BaseLeButton.titleLabel?.font = HedgeSysFont14
        BaseRiButton.titleLabel?.font = HedgeSysFont14
        BaseLeButton.setTitleColor(HedgColor153, for: .normal)
        BaseRiButton.setTitleColor(HedColorBlack, for: .normal)
        
        
        BaseLeButton.addTarget(self, action: #selector(BaseSeleDataButton(_:)), for: .touchUpInside)
        BaseRiButton.addTarget(self, action: #selector(BaseSeleDataButton(_:)), for: .touchUpInside)
        
        
        let dataStL = UILabel.init()
        picTopV.addSubview(dataStL)
        dataStL.easy.layout(Right(10).to(BaseRiButton,.left),Left(10).to(BaseLeButton,.right),Top(0),Bottom(0))
        dataStL.font = HedgeSysFont18
        dataStL.textColor = HedgColor25
        dataStL.textAlignment = .center
        dataStL.text = title
        
        return datePicker
        
    }
    
    func BaseSeleDataHidden(){
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            
            self.BaseBottomV.easy.layout(Height(193+61+STATUS_BAR_HEIGHT))
            self.BasebackV.backgroundColor = HedgColor25.withAlphaComponent(0.8)
            self.BasebackV.isHidden = false
        }
        
    }
    @objc func BaseSeleDataButton(_ button:UIButton){
        
        UIView.animate(withDuration: 0.3) {
            self.BaseBottomV.easy.layout(Height(0))
            self.BasebackV.backgroundColor = HedgColor25.withAlphaComponent(0)
            self.BasebackV.isHidden = true
            
        }
        
        if BaseLeButton == button{
            
            
        }else{
            
        }
    }
    
    
}
