//
//  GraphView.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/28/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

protocol GraphViewDelegate {
    func editTitle()
}

class GraphView: UIScrollView, UIScrollViewDelegate {

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

    var titleDelegate : GraphViewDelegate!
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
        minimumZoomScale = 0.1
        maximumZoomScale = 5.0
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
            newestNodeView = nodeView
            containerView.addSubview(nodeView)
            println("Created node! Tiny Rick!")
        }
        titleDelegate.editTitle()
    }
}
