//
//  ImageSelectorScrollView.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 02.12.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import UIKit

class ImageSelectorScrollView: UIScrollView {
    
    var currentX = 10.0
    var currentY = 7.0
    let itemWidth = 45.0
    let itemHeight = 45.0
    let spaceWidth = 10.0
    
    override func drawRect(rect: CGRect) {
        var roundedRect = UIBezierPath(roundedRect:self.bounds, cornerRadius: 12.0)
        roundedRect.addClip()
        UIColor.whiteColor().setFill()
        UIRectFill(self.bounds)
        
        UIColor.blackColor().setStroke()
        roundedRect.stroke()
        
    }
    
    func addItem(item: UIView) {
        let frame = CGRect(x: currentX, y: currentY, width: itemWidth, height: itemHeight)
        currentX += spaceWidth + itemWidth
        item.frame = frame
        self.addSubview(item)
        
        //self.contentSize = CGSize(width: currentX, height: itemHeight)
    }
}
