//
//  GraphView.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/28/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

protocol NodeCreatedDelegate {
    func nodeCreated(#node: NodeView)
}

class GraphView: UIScrollView, UIScrollViewDelegate {

    let RGB_VALUES : [(CGFloat, CGFloat, CGFloat)] = [
        (155, 196, 226),
        ]

    var nodeCreatedDelegate : NodeCreatedDelegate!
    var newestNodeView : NodeView?
    var containerView : UIView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let containerSize = CGSizeMake(
            screenSize.width * 10,
            screenSize.height * 10)

        self.contentSize = containerSize
        self.contentOffset = CGPointMake(
            (containerSize.width / 2) - (screenSize.width / 2),
            (containerSize.height / 2) - (screenSize.height / 2))

        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:containerSize))
        containerView.backgroundColor = UIColor.whiteColor()
        self.addSubview(containerView)

        // NOTE: Zooming in not interesting, zooming out is. Fix scale to reflect that.
        minimumZoomScale = 0.5
        maximumZoomScale = 2.0
        zoomScale = 1.0
    }

    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        newestNodeView?.setNeedsDisplay()
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return containerView
    }

    @IBAction func longTap(sender: UILongPressGestureRecognizer) {
        userInteractionEnabled = false
        if (UIGestureRecognizerState.Began == sender.state) {
            let location = sender.locationOfTouch(0, inView: containerView)
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
            println("Created node! Tiny Rick!")
            nodeCreatedDelegate.nodeCreated(node: nodeView)
        }
    }
}
