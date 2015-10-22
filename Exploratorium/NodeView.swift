//
//  NodeView.swift
//  Exploratorium
//
//  Created by Adam Bossy on 10/6/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

protocol NodeTapDelegate {
    func nodeTapped(node: NodeView)
}

class NodeView : UIView {

    let NODE_SIZE = CGFloat(80.0)
    let TEXT_MARGIN = CGFloat(10.0)
    let TEXT_HEIGHT = CGFloat(22.0)
    let LINE_WIDTH = CGFloat(6.0)
    let color : UIColor

    var title : String!
    var delegate : NodeTapDelegate? // Should be weak but Xcode won't let me

    init(x: CGFloat, y: CGFloat, title: String?, color: UIColor) {
        self.title = title
        self.color = color

        let initFrame = CGRect(x: x + (NODE_SIZE / 2), y: y + (NODE_SIZE / 2), width: 1, height: 1)
        super.init(frame: initFrame)

        let targetFrame = CGRect(
            x: x - (LINE_WIDTH / 2),
            y: y - (LINE_WIDTH / 2),
            width: NODE_SIZE + LINE_WIDTH,
            height: NODE_SIZE + TEXT_MARGIN + TEXT_HEIGHT + LINE_WIDTH)
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.0,
            options: .CurveEaseInOut,
            animations: {
                self.frame = targetFrame
            },
            completion: { (finished: Bool) in })
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
            NSFontAttributeName: UIFont.boldSystemFontOfSize(20.0),
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSParagraphStyleAttributeName: textStyle
        ]
        let titleRect = CGRectMake(0, NODE_SIZE + LINE_WIDTH + TEXT_MARGIN, NODE_SIZE + LINE_WIDTH, TEXT_HEIGHT)
        self.title?.drawInRect(titleRect, withAttributes: titleAttributes)
    }

    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let d = delegate {
            d.nodeTapped(self)
        }
    }
}
