//
//  ScreenViewCollectionViewCell.swift
//  chezhijia
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class ScreenViewCollectionViewCell: UICollectionViewCell {

    
    var nameLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
     
        
        
        
        nameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height:0))
        
  
        
        self.addSubview(nameLabel);
        

        
        nameLabel.easy.layout(CenterX(0),Left(0),Right(0),Height(30))
        
        
        nameLabel.layer.masksToBounds = true;
        nameLabel.layer.cornerRadius = 10.0;
        nameLabel.clipsToBounds = true;
        
        
        
        
//        nameLabel.text = "探索文化"
        nameLabel.textColor = HedColorBlack
        nameLabel.font = HedgeSysFont14
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = HedColorWhite
        
        
        

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
