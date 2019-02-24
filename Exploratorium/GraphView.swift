//
//  GraphView.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/28/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

protocol NodeCreatedDelegate {
    func nodeCreated(node: NodeView)
//    func debugNodeCreated(node: NodeView)
}

class GraphView: UIScrollView, UIScrollViewDelegate {

    let RGB_VALUES : [(CGFloat, CGFloat, CGFloat)] = [
        (155, 196, 226),
        ]

//    var DEBUG : Bool = true
//    var debugNode: NodeView!

    var nodeCreatedDelegate : NodeCreatedDelegate!
    var newestNodeView : NodeView?
    var containerView : UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let screenSize: CGRect = UIScreen.main.bounds
        let containerSize = CGSize(
            width: screenSize.width * 10,
            height: screenSize.height * 10)

        self.contentSize = containerSize
        self.contentOffset = CGPoint(
            x: (containerSize.width / 2) - (screenSize.width / 2),
            y: (containerSize.height / 2) - (screenSize.height / 2))

        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:containerSize))
        containerView.backgroundColor = UIColor.white
        self.addSubview(containerView)

        // NOTE: Zooming in not interesting, zooming out is. Fix scale to reflect that.
        minimumZoomScale = 0.5
        maximumZoomScale = 2.0
        zoomScale = 1.0

        // DEBUG NODE
//        if DEBUG {
//            let color = UIColor(
//                red: RGB_VALUES[0].0 / 255.0,
//                green: RGB_VALUES[0].1  / 255.0,
//                blue: RGB_VALUES[0].2 / 255.0,
//                alpha: 1.0)
//            debugNode = NodeView(x: 0, y: 0, title: nil, color: color)
//            newestNodeView = debugNode
//            containerView.addSubview(debugNode)
//            nodeCreatedDelegate.debugNodeCreated(debugNode)
//        }
    }

    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        newestNodeView?.setNeedsDisplay()
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return containerView
    }

    @IBAction func longTap(sender: UILongPressGestureRecognizer) {
        isUserInteractionEnabled = false
        if (UIGestureRecognizer.State.began == sender.state) {
            let location = sender.location(ofTouch: 0, in: containerView)
            let index = Int(arc4random_uniform(UInt32(RGB_VALUES.count)))
            let color = UIColor(
                red: RGB_VALUES[index].0 / 255.0,
                green: RGB_VALUES[index].1  / 255.0,
                blue: RGB_VALUES[index].2 / 255.0,
                alpha: 1.0)
            let nodeView = NodeView(x: location.x - 50, y: location.y - 50, title: nil, color: color)
//            nodeView.delegate = nodeCreatedDelegate // Seems hacky
            newestNodeView = nodeView
            containerView.addSubview(nodeView)
            print("Created node! Tiny Rick!")
            nodeCreatedDelegate.nodeCreated(node: nodeView)
        }
    }
}
