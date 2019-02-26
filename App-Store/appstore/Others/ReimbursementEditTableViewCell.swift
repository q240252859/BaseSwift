//
//  ReimbursementEditTableViewCell.swift
//  chezhijia
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import EasyPeasy

class ReimbursementEditTableViewCell: UITableViewCell {

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
    let conL = UITextField.init()
    let lin = UIView.init()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI() {
        self.addSubview(titLabel)
        titLabel.easy.layout(CenterY(0),Left(15),Width("客户姓名户姓名".ga_widthForComment(fontSize: HedgeSysFont13)),Height(30))
        
        titLabel.textColor = HedgColor153
        titLabel.font = HedgeSysFont13
        titLabel.text = "客户姓名"
        
        
        self.addSubview(conL)
        conL.easy.layout(CenterY(0).to(titLabel),Left(5).to(titLabel),Right(15),Height(30))
        
        conL.textColor = HedgColor51
        conL.font = HedgeSysFont13
        conL.text = "某某某"
        
        
        self.addSubview(lin)
        lin.backgroundColor = HedgeColor242
        lin.easy.layout(Bottom(0),Right(0),Left(15),Height(1))
    }
}
