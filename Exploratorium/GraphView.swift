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
//    var graph : [NodeView: [NodeView]]
    var titleDelegate : GraphViewDelegate!
    var newestNodeView : NodeView?
    var containerView : UIView!

//    @IBOutlet weak var containerView: UIView!

    required init(coder aDecoder: NSCoder) {
//        graph = [NodeView: [NodeView]]()
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

        // TODO: Move to IB. Come back to this later.
//        let titleRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: screenSize.width, height: 22))
//        let titleLabel = UILabel(frame: titleRect)
//        titleLabel.text = "Exploratorium"
//        titleLabel.numberOfLines = 0
//        titleLabel.font = .boldSystemFontOfSize(36.0)
//        titleLabel.shadowColor = .lightGrayColor()
//        titleLabel.shadowOffset = CGSize(width: 0, height: 1)
//        titleLabel.alpha = 0.25
//        titleLabel.sizeToFit()
//        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//        containerView.addSubview(titleLabel)
//        containerView.addConstraint(NSLayoutConstraint(
//            item: titleLabel,
//            attribute: .CenterX,
//            relatedBy: .Equal,
//            toItem: containerView,
//            attribute: .CenterX,
//            multiplier: 1,
//            constant: 0))
//        containerView.addConstraint(NSLayoutConstraint(
//            item: titleLabel,
//            attribute: .CenterY,
//            relatedBy: .Equal,
//            toItem: containerView,
//            attribute: .CenterY,
//            multiplier: 1,
//            constant: 0))

        // NOTE: Zooming in not interesting, zooming out is. Fix scale to reflect that.
        minimumZoomScale = 0.1
        maximumZoomScale = 5.0
        zoomScale = 1.0
        
//        centerContainerView()
    }

    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        newestNodeView?.setNeedsDisplay()
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return containerView
    }

    func scrollViewDidZoom(scrollView: UIScrollView) {
        println(String(format: "zoomScale: %.5f bounds width: %.5f height %.5f offset x %.5f y %.5f", zoomScale, containerView.frame.size.width, containerView.frame.size.height, self.contentOffset.x, self.contentOffset.y))
          // NOTE: Hard to do without glitchiness. Figure out later.
//        if (zoomScale < minimumZoomScale) {
//            centerContainerView()
//        }
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        println(String(format: "zooming ended! %.5f", zoomScale))
    }

    func centerContainerView() {
        let boundsSize = bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        }
        
        containerView.frame = contentsFrame
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
//            graph[nodeView] = [NodeView]()
            newestNodeView = nodeView
            containerView.addSubview(nodeView)
            println("Created node! Tiny Rick!")
        }
        titleDelegate.editTitle()
    }
}
