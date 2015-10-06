//
//  GraphScene.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/28/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

protocol GraphSceneDelegate {
    func editTitle()
}

class GraphScene: UIView {

    let NODE_SIZE = CGFloat(80.0)
    let RGB_VALUES : [(CGFloat, CGFloat, CGFloat)] = [
        (68, 105, 61),
        (173, 220, 145),
        (161, 216, 132),
        (108, 194, 74),
        (67, 176, 42),
        (80, 158, 47),
        (76, 140, 43),
        (74, 119, 41),
        (208, 222, 187),
        (188, 225, 148),
        (142, 221, 101),
        (120, 214, 75),
        (116, 170, 80),
        (113, 153, 73),
        (121, 134, 60),
        (194, 225, 137),
        (183, 221, 121),
        (164, 214, 94),
        (120, 190, 32),
        (100, 167, 11),
        (101, 141, 27)
        ]
    var graph : [Node: [Node]]
    var delegate : GraphSceneDelegate!
    var newestNode : Node?
    
    required init(coder aDecoder: NSCoder) {
        graph = [Node: [Node]]()
        super.init(coder: aDecoder)
    }

    override func drawRect(rect: CGRect) {
        for (node, _) in graph {
            let nodeRect = CGRect(
                x: node.x,
                y: node.y,
                width: NODE_SIZE,
                height: NODE_SIZE)
            var path = UIBezierPath(ovalInRect: nodeRect)
            node.color.setFill()
            path.fill()
            
            UIColor.blackColor().setStroke()
            path.lineWidth = 6.0
            path.stroke()
            
            var textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .Center
            let titleAttributes = [
                NSFontAttributeName: UIFont.systemFontOfSize(16.0),
                NSForegroundColorAttributeName: UIColor.blackColor(),
                NSParagraphStyleAttributeName: textStyle
            ]
            let titleRect = CGRectMake(node.x, node.y + NODE_SIZE + 10.0, NODE_SIZE, 22)
            node.title?.drawInRect(titleRect, withAttributes: titleAttributes)
        }
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        userInteractionEnabled = false
        for touch in touches {
            let touch_ = touch as! UITouch
            let location = touch_.locationInView(self)
            let index = Int(arc4random_uniform(UInt32(RGB_VALUES.count)))
            let color = UIColor(
                red: RGB_VALUES[index].0 / 255.0,
                green: RGB_VALUES[index].1  / 255.0,
                blue: RGB_VALUES[index].2 / 255.0,
                alpha: 1.0)
            let node = Node(x: location.x - 50, y: location.y - 50, title: nil, color: color)
            graph[node] = [Node]()
            newestNode = node
            self.setNeedsDisplay()
        }
        self.delegate.editTitle()
    }
}
