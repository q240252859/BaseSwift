//
//  ScreenView.swift
//  chezhijia
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

protocol ScreenViewDelegate {
    func ScreenViewDidIndex(_ type: [String:Any])
}

class ScreenView: UIView,UICollectionViewDataSource, UICollectionViewDelegate, MYCollectionViewDelegateFlowLayout  {
    var delegeate : ScreenViewDelegate?
    var collectionView: UICollectionView!
    
    var ScreenParams:[String:Any] = [:]{
        didSet{
            var arr : [String] = []
            var arrK: [String] = []
            let clientName = ScreenParams["clientName"] as? String ?? ""
            let phone = ScreenParams["phone"] as? String ?? ""
            let createTimeMin = ScreenParams["createTimeMin"] as? String ?? ""
            let createTimeMax = ScreenParams["createTimeMax"] as? String ?? ""
            if clientName.count>0{
                arr.append("客户姓名："+clientName)
                arrK.append("clientName")
            }
            if phone.count>0{
                arr.append("客户手机号码："+phone)
                arrK.append("phone")
            }
            let createTime = "创建时间："
            if createTimeMin.count>0 || createTimeMax.count>0{
                arr.append(createTime+createTimeMin+"——"+createTimeMax)
                arrK.append("createTimeMin")
            }
            self.arrStr = arr
            self.arrKey = arrK
            
        }
    }
    
    var arrKey : [String] = []
    var arrStr : [String] = []{didSet{
     
        collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
        //       let consi = self.collectionView.contentSize
        let sizz = collectionView.collectionViewLayout.collectionViewContentSize
        self.frame = CGRect.init(x: 0, y: 0, width: sizz.width, height: sizz.height)
        
        }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       

       
    }
    func setUI(){
        
        let layout = MYCollectionViewFlowLayout.init()
        //
        //        layout.itemSize = CGSize.init(width: (ScreenWidth-46)/3, height: 40)
        layout.minimumLineSpacing = 8
        
        layout.minimumInteritemSpacing = 10
        
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 15, bottom: 0, right: 15)
        //垂直滚动
        layout.scrollDirection = .vertical
        
        self.collectionView  =  UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        self.addSubview(collectionView)
        
        self.collectionView.easy.layout(
            Top(0),
            Right(0),Left(0),Bottom(0)
        )
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = HedgeColor242
        
        self.collectionView.register(ScreenViewCollectionViewCell.self, forCellWithReuseIdentifier: "CELL_ConID")
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
         return CGSize(width: arrStr[indexPath.row].ga_widthForComment(fontSize: HedgeSysFont14, height: 40)+30, height: 40)
        
    }
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrStr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ConID", for: indexPath) as! ScreenViewCollectionViewCell
        cell.nameLabel.text = arrStr[indexPath.row]
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
      
        var Screen:[String:Any] = [:]
        
       
        for (_,mo) in ScreenParams.enumerated(){
            Screen[mo.key] = mo.value
            if arrKey[indexPath.row] == "createTimeMin"{
                Screen["createTimeMin"] = ""
                Screen["createTimeMax"] = ""
            }else if (mo.key ) == arrKey[indexPath.row]{
                Screen[mo.key] = ""
            }
        }
        
        if delegeate != nil{
            delegeate?.ScreenViewDidIndex(Screen)
        }
        arrStr.remove(at: indexPath.row)
        arrKey.remove(at: indexPath.row)
        
        self.collectionView.reloadData()
    }

}
