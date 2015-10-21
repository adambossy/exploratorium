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
    var originFrame = CGRect.zeroRect

    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        container.backgroundColor = UIColor.clearColor() // Remove black background

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

        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
            
            notesView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
            notesView.center = CGPoint(x: CGRectGetMidX(finalFrame),
                y: CGRectGetMidY(finalFrame))
            notesView.alpha = self.presenting ? 1.0 : 0.0

            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
        })
        
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1
    }
    
}