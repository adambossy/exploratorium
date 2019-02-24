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
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.0,
            options: .curveEaseInOut,
            animations: {
                self.frame = targetFrame
            },
            completion: { (finished: Bool) in })
        self.backgroundColor = UIColor.clear
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    

    override func draw(_ rect: CGRect) {
        let nodeRect = CGRect(
            x: (LINE_WIDTH / 2),
            y: (LINE_WIDTH / 2),
            width: NODE_SIZE,
            height: NODE_SIZE)
        let path = UIBezierPath(ovalIn: nodeRect)
        self.color.setFill()
        path.fill()
        
        UIColor.black.setStroke()
        path.lineWidth = LINE_WIDTH
        path.stroke()
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: textStyle
        ]
        let titleRect = CGRect(
            x: 0,
            y: NODE_SIZE + LINE_WIDTH + TEXT_MARGIN,
            width: NODE_SIZE + LINE_WIDTH,
            height: TEXT_HEIGHT
        )
        self.title?.draw(in: titleRect, withAttributes: titleAttributes)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let d = delegate {
            d.nodeTapped(node: self)
        }
    }
}
