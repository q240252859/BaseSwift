//
//  MYCollectionViewFlowLayout.swift
//  MyCollectionViewFlowLayout
//
//  Created by minse on 2017/6/5.
//  Copyright © 2017年 China. All rights reserved.
//

import UIKit

enum AlignedDirection {
    case left,
    rightData,
    rightFlow,
    center,
    auto
}

protocol MYCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    //代理方法, 返回collectionView内容的高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, collectionViewHeight height: CGFloat)
}

extension MYCollectionViewDelegateFlowLayout {
    //默认实现, 此方法在代理中为可选
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, collectionViewHeight: CGFloat) {}
}

class MYCollectionViewFlowLayout: UICollectionViewFlowLayout {
    //对齐方向
    var direction: AlignedDirection = .left
    //所有cell的布局属性
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    //每一行cell的布局属性
    private var layoutLine = [UICollectionViewLayoutAttributes]()
    private var contentSize: CGSize = CGSize.zero
    
    override var collectionViewContentSize : CGSize {
        guard let collectionView = self.collectionView else {
            return contentSize
        }
        switch self.scrollDirection {
        case .vertical:
            return CGSize(width: collectionView.frame.width, height: contentSize.height)
        case .horizontal:
            return CGSize(width: contentSize.width, height: collectionView.frame.height)
        }
    }
    
    override init() {
        super.init()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        super.prepare()
        //清空之前的布局属性
        layoutAttributes.removeAll()
        layoutLine.removeAll()
        //重置collectionView的contentSize
        contentSize = CGSize.zero
        //考虑header和footer
        if let collectionView = self.collectionView {
            let sections = collectionView.numberOfSections
            for i in 0..<sections {
                let rows = collectionView.numberOfItems(inSection: i)
                if let layoutAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath.init(row: 0, section: i)) {
                    layoutAttributes.append(layoutAttr)
                }
                for j in 0..<rows {
                    if let layoutAttr = layoutAttributesForItem(at: IndexPath.init(row: j, section: i)) {
                        layoutAttributes.append(layoutAttr)
                    }
                }
                if let layoutAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionFooter, at: IndexPath.init(row: 0, section: i)) {
                    layoutAttributes.append(layoutAttr)
                }
            }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //size默认为itemSize
        var size = self.itemSize
        //从代理方法获取item的size
        if let collectionView = self.collectionView, let flowLayoutDelegate = collectionView.delegate as? MYCollectionViewDelegateFlowLayout {
            if let delegateSize = flowLayoutDelegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) {
                size = delegateSize
            }
        }
        //初始化每个item的frame
        var frame = CGRect.zero
        //初始化x, y
        var x: CGFloat = 0
        var y: CGFloat = 0
        //从layoutAttributes中获取上一个item 如果获取不到 设置现在的item为第一个item
        //判断collectionView的滑动方向
        if self.scrollDirection == .vertical {
            //获取collectionView的宽度
            let collectionViewWidth: CGFloat = self.collectionView!.bounds.width
            //根据对齐方向判断初始值
            if direction == .left || direction == .rightFlow || direction == .center {
                //左对齐
                x = self.sectionInset.left
                y = self.sectionInset.top
                //判断是否上一个item
                if layoutAttributes.count>0 {
                    //获取上一个item
                    if let lastLayoutAttr = layoutAttributes.last {
                        //判断当前行的宽度是否足够插入新的item
                        if lastLayoutAttr.frame.maxX+self.minimumInteritemSpacing+size.width+self.sectionInset.right>collectionViewWidth {
                            //如果宽度总和超过总宽度, 改变y坐标, 当前的item在下一行显示
                            y = lastLayoutAttr.frame.maxY+self.minimumLineSpacing
                            reloadlayoutAttributes() //新加的代码
                        }else{
                            //如果宽度可以插入item, 修改坐标点, y轴与上一个item平齐, x轴则为上一个item的最右边加上行间距
                            x = lastLayoutAttr.frame.maxX+self.minimumInteritemSpacing
                            y = lastLayoutAttr.frame.minY
                        }
                    }
                }
            }else if direction == .rightData{
                //右对齐
                x = collectionViewWidth-self.sectionInset.right-size.width
                y = self.sectionInset.top
                if layoutAttributes.count>0 {
                    if let lastLayoutAttr = layoutAttributes.last {
                        if lastLayoutAttr.frame.minX-self.minimumInteritemSpacing-size.width-self.sectionInset.left<0 {
                            y = lastLayoutAttr.frame.maxY+self.minimumLineSpacing
                        }else{
                            x = lastLayoutAttr.frame.minX-self.minimumInteritemSpacing-size.width
                            y = lastLayoutAttr.frame.minY
                        }
                    }
                }
            }else if direction == .auto{
                if layoutAttributes.count>0 {
                    if let lastLayoutAttr = layoutAttributes.last {
                        if lastLayoutAttr.frame.maxX+self.minimumInteritemSpacing+size.width+self.sectionInset.right>collectionViewWidth {
                            self.direction = .left
                            self.minimumInteritemSpacing = (self.collectionViewContentSize.width-self.sectionInset.left-self.sectionInset.right-(size.width*CGFloat(layoutAttributes.count+1)))/CGFloat(layoutAttributes.count)
                            self.collectionView?.reloadData()
                            y = lastLayoutAttr.frame.maxY+self.minimumLineSpacing
                        }else{
                            x = lastLayoutAttr.frame.maxX+self.minimumInteritemSpacing
                            y = lastLayoutAttr.frame.minY
                        }
                    }
                }
            }
        }else {
            //水平方向滑动
            var collectionViewHeight: CGFloat = contentSize.height
            if let collectionView = self.collectionView {
                collectionViewHeight = collectionView.bounds.height
            }
            if layoutAttributes.count>0 {
                if let lastLayoutAttr = layoutAttributes.last {
                    if lastLayoutAttr.frame.maxY+self.minimumInteritemSpacing+size.height+self.sectionInset.bottom>collectionViewHeight {
                        x = lastLayoutAttr.frame.maxX+self.minimumLineSpacing
                    }else{
                        y = lastLayoutAttr.frame.maxY+self.minimumInteritemSpacing
                        x = lastLayoutAttr.frame.minX
                    }
                }
            }
        }
        //设置item的frame
        frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        //更新contentSize, 此处赋值有时候不是最大值, 如果需要用到collectionViewContentSize这个属性, 需要判断新的值是否比原值大
        contentSize.width = frame.maxX+self.sectionInset.right
        contentSize.height = frame.maxY+self.sectionInset.bottom
        //创建每个item对应的布局属性
        let layoutAttr = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        layoutAttr.frame = frame
        layoutLine.append(layoutAttr)
        if let collection = self.collectionView, indexPath.row == collection.numberOfItems(inSection: indexPath.section)-1 {
            reloadlayoutAttributes() //新加的代码
        }
        return layoutAttr
    }
    
    //重新绘制布局
    func reloadlayoutAttributes() {
        if layoutLine.count == 0 {return} //防止越界
        //重新绘制布局有右对齐和居中对齐两种
        if direction == .rightFlow || direction == .center {
            //计算填充比例, rightFlow为1, center为0.5
            let scale: CGFloat = direction == .rightFlow ? 1 : 0.5
            //先获取空白部分的宽度(即是填充宽度的大小)
            if let collectionView = self.collectionView, let last = layoutLine.last {
                let space = (collectionView.bounds.width-last.frame.maxX-self.sectionInset.right)*scale
                for layout in layoutLine {
                    var newFrame = layout.frame
                    newFrame.origin.x += space
                    layout.frame = newFrame
                }
            }
        }
        layoutLine.removeAll()
    }
    
    override func layoutAttributesForElements(in rect:CGRect) -> [UICollectionViewLayoutAttributes]{
        if let collectionView = self.collectionView, let flowLayoutDelegate = collectionView.delegate as? MYCollectionViewDelegateFlowLayout{
            flowLayoutDelegate.collectionView(collectionView, layout: self, collectionViewHeight: self.contentSize.height)
        }
        return layoutAttributes
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
//        
//        // Helpers
//        let sectionsToAdd = NSMutableIndexSet()
//        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
//        
//        for layoutAttributesSet in layoutAttributes {
//            if layoutAttributesSet.representedElementCategory == .cell {
//                // Add Layout Attributes
//                newLayoutAttributes.append(layoutAttributesSet)
//                
//                // Update Sections to Add
//                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
//                
//            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
//                // Update Sections to Add
//                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
//            }
//        }
//        
//        for section in sectionsToAdd {
//            let indexPath = IndexPath(item: 0, section: section)
//            
//            if let sectionAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath) {
//                newLayoutAttributes.append(sectionAttributes)
//            }
//        }
//        
//        return newLayoutAttributes
//    }
    
//    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
//        guard let boundaries = boundaries(forSection: indexPath.section) else { return layoutAttributes }
//        guard let collectionView = collectionView else { return layoutAttributes }
//        
//        // Helpers
//        let contentOffsetY = collectionView.contentOffset.y
//        var frameForSupplementaryView = layoutAttributes.frame
//        
//        let minimum = boundaries.minimum - frameForSupplementaryView.height
//        let maximum = boundaries.maximum - frameForSupplementaryView.height
//        
//        if contentOffsetY < minimum {
//            frameForSupplementaryView.origin.y = minimum
//        } else if contentOffsetY > maximum {
//            frameForSupplementaryView.origin.y = maximum
//        } else {
//            frameForSupplementaryView.origin.y = contentOffsetY
//        }
//        
//        layoutAttributes.frame = frameForSupplementaryView
//        
//        return layoutAttributes
//    }
//    
//    // MARK: - Helper Methods
//    
//    func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
//        // Helpers
//        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))
//        
//        // Exit Early
//        guard let collectionView = collectionView else { return result }
//        
//        // Fetch Number of Items for Section
//        let numberOfItems = collectionView.numberOfItems(inSection: section)
//        
//        // Exit Early
//        guard numberOfItems > 0 else { return result }
//        
//        if let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
//            let lastItem = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: section)) {
//            result.minimum = firstItem.frame.minY
//            result.maximum = lastItem.frame.maxY
//            
//            // Take Header Size Into Account
//            result.minimum -= headerReferenceSize.height
//            result.maximum -= headerReferenceSize.height
//            
//            // Take Section Inset Into Account
//            result.minimum -= sectionInset.top
//            result.maximum += (sectionInset.top + sectionInset.bottom)
//        }
//        
//        return result
//    }
    
    
}
