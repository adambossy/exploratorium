//
//  NotesTransitionAnimator.swift
//  Exploratorium
//
//  Created by Adam Bossy on 10/21/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class NotesTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var presenting  = true
    var originFrame = CGRect.zero

    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()!

        let notesView = transitionContext.viewForKey(presenting ? UITransitionContextToViewKey : UITransitionContextFromViewKey)!
        let graphView = transitionContext.viewForKey(presenting ? UITransitionContextFromViewKey : UITransitionContextToViewKey)!

        let initialFrame = presenting ? originFrame : notesView.frame
        let finalFrame = presenting ? notesView.frame : originFrame

        let xScaleFactor = presenting ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width
         
        let yScaleFactor = presenting ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)

        if presenting {
            notesView.transform = scaleTransform
            notesView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            notesView.clipsToBounds = true
            notesView.alpha = 0.0
        } else {
            notesView.alpha = 1.0
        }

        if !presenting {
            container.addSubview(graphView)
        }

        container.addSubview(notesView)
        container.bringSubviewToFront(notesView)

        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(
            duration,
            delay: NSTimeInterval(0),
            options: [],
            animations: {
                notesView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                notesView.center = CGPoint(x: CGRectGetMidX(finalFrame),
                    y: CGRectGetMidY(finalFrame))
                notesView.alpha = self.presenting ? 1.0 : 0.0
            }, completion: { finished in
                // tell our transitionContext object that we've finished animating
                
                transitionContext.completeTransition(true)
            }
        )
        
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
}