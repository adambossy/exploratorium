//
//  NodeView.swift
//  Exploratorium
//
//  Created by Adam Bossy on 10/6/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class NodeView : UIView {

    let NODE_SIZE = CGFloat(80.0)
    let TEXT_MARGIN = CGFloat(10.0)
    let TEXT_HEIGHT = CGFloat(22.0)
    let LINE_WIDTH = CGFloat(6.0)

    var title : String!
    let color : UIColor

    init(x: CGFloat, y: CGFloat, title: String?, color: UIColor) {
        self.title = title
        self.color = color
        super.init(frame: CGRect(
            x: x - (LINE_WIDTH / 2),
            y: y - (LINE_WIDTH / 2),
            width: NODE_SIZE + LINE_WIDTH,
            height: NODE_SIZE + TEXT_MARGIN + TEXT_HEIGHT + LINE_WIDTH))
        self.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func drawRect(rect: CGRect) {
        let nodeRect = CGRect(
            x: (LINE_WIDTH / 2),
            y: (LINE_WIDTH / 2),
            width: NODE_SIZE,
            height: NODE_SIZE)
        var path = UIBezierPath(ovalInRect: nodeRect)
        self.color.setFill()
        path.fill()
        
        UIColor.blackColor().setStroke()
        path.lineWidth = LINE_WIDTH
        path.stroke()
        
        var textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .Center
        let titleAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(16.0),
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSParagraphStyleAttributeName: textStyle
        ]
        let titleRect = CGRectMake(0, NODE_SIZE + LINE_WIDTH + TEXT_MARGIN, NODE_SIZE + LINE_WIDTH, TEXT_HEIGHT)
        self.title?.drawInRect(titleRect, withAttributes: titleAttributes)
    }
    
}
