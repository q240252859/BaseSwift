//
//  CustomerBlacklistTableViewCell.swift
//  chezhijia
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import EasyPeasy

protocol CustomerBlacklistDelegate {
    func didMoreAt(index:Int,indexPath: IndexPath)
}
class CustomerBlacklistTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    let titLabel = UILabel.init()
    let conL = UILabel.init()
    let BottomL = UILabel.init()
        let RightL = UILabel.init()
    let RightTwoB = UIButton.init(type: UIButtonType.custom)
    let RightOneB = UIButton.init(type: UIButtonType.custom)
    let RightThreeB = UIButton.init(type: UIButtonType.custom)
    
    var indexPath: IndexPath!
    
    var delegate:CustomerBlacklistDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI() {
        let WBottomV = UIView.init()
        WBottomV.backgroundColor = HedColorWhite
        WBottomV.layer.cornerRadius = 3
        WBottomV.clipsToBounds = true
        WBottomV.layer.masksToBounds = true
        self.addSubview(WBottomV)
        WBottomV.easy.layout(Left(10),Right(10),Bottom(0),Top(0))
        
//        WBottomV.addSubview(RightL)
//        RightL.easy.layout(Top(12),Width((ScreenWidth-40)/2.0),Right(10),Height(14))
//        RightL.text = "所属行业：科技  自主开发"
//        RightL.font = HedMediumFont15
//        RightL.textColor = HedgColor51
//        RightL.textAlignment = .right
        
        WBottomV.addSubview(titLabel)
        titLabel.easy.layout(Top(10),Left(10),Width((screenWidth-40)),Height(18))
        
        titLabel.textColor = HedgColor51
        titLabel.font = HedgeSysFont15
        titLabel.text = "某某某    某某某公司"
        
        
        WBottomV.addSubview(conL)
        conL.easy.layout(Top(10).to(titLabel),Left(10),Right(10),Height(12))
        //        conL.textAlignment = .center
        conL.textColor = HedgColor153
        conL.font = HedgeSysFont13
        conL.text = "13888888888"
        
        
        WBottomV.addSubview(BottomL)
        BottomL.easy.layout(Top(12).to(conL),Left(10),Right(10),Height(14))
        //        conL.textAlignment = .center
        BottomL.textColor = HedgColor51
        BottomL.font = HedgeSysFont13
        BottomL.text = "地址：广东省深圳市福田区某某大厦"
        
        let lin = UIView.init()
        WBottomV.addSubview(lin)
        lin.backgroundColor = HedgeColor242
        lin.easy.layout(Top(10).to(BottomL),Right(10),Left(10),Height(1))
        
        
        WBottomV.addSubview(RightOneB)
        RightOneB.easy.layout(Top(9).to(lin),Width("删除".ga_widthForComment(fontSize: HedgeSysFont12)+24),Right(10),Height(20))
        RightOneB.setTitle("删除", for: .normal)
        RightOneB.setTitleColor(HedgColor248, for: UIControlState.normal)
        RightOneB.titleLabel?.font  = HedgeSysFont12
        RightOneB.layer.cornerRadius = 10
        RightOneB.clipsToBounds = true
        RightOneB.layer.masksToBounds = true
        RightOneB.layer.borderColor = HedgColor248.cgColor
        RightOneB.layer.borderWidth = 1
        RightOneB.addTarget(self, action: #selector(didRightB(_:)), for: .touchUpInside)
        
        WBottomV.addSubview(RightTwoB)
        RightTwoB.easy.layout(Top(9).to(lin),Width("编辑".ga_widthForComment(fontSize: HedgeSysFont12)+24),Right(22).to(RightOneB,.left),Height(20))
        RightTwoB.setTitle("编辑", for: .normal)
        RightTwoB.setTitleColor(HedgColor248, for: UIControlState.normal)
        RightTwoB.titleLabel?.font  = HedgeSysFont12
        RightTwoB.layer.cornerRadius = 10
        RightTwoB.clipsToBounds = true
        RightTwoB.layer.masksToBounds = true
        RightTwoB.layer.borderColor = HedgColor248.cgColor
        RightTwoB.layer.borderWidth = 1
        RightTwoB.addTarget(self, action: #selector(didRightB(_:)), for: .touchUpInside)
        
//        WBottomV.addSubview(RightThreeB)
//        RightThreeB.easy.layout(Top(9).to(lin),Width("编辑".ga_widthForComment(fontSize: HedgeTitleFont12)+24),Right(22).to(RightTwoB,.left),Height(20))
//        RightThreeB.setTitle("编辑", for: .normal)
//        RightThreeB.setTitleColor(HedgColor248, for: UIControlState.normal)
//        RightThreeB.titleLabel?.font  = HedgeTitleFont12
//        RightThreeB.layer.cornerRadius = 10
//        RightThreeB.clipsToBounds = true
//        RightThreeB.layer.masksToBounds = true
//        RightThreeB.layer.borderColor = HedgColor248.cgColor
//        RightThreeB.layer.borderWidth = 1
//        RightThreeB.addTarget(self, action: #selector(didRightB(_:)), for: .touchUpInside)
        
    }
    @objc func didRightB(_ button:UIButton){
        if button == RightOneB {
            delegate?.didMoreAt(index: 1, indexPath: indexPath)
        }else if button == RightTwoB{
            delegate?.didMoreAt(index: 2, indexPath: indexPath)
        }else{
            delegate?.didMoreAt(index: 3, indexPath: indexPath)
        }
    }
    
}
