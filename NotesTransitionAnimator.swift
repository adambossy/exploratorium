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
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView

        let notesView = transitionContext.view(forKey: presenting ? UITransitionContextViewKey.to : UITransitionContextViewKey.from)!
        let graphView = transitionContext.view(forKey: presenting ? UITransitionContextViewKey.from : UITransitionContextViewKey.to)!

        let initialFrame = presenting ? originFrame : notesView.frame
        let finalFrame = presenting ? notesView.frame : originFrame

        let xScaleFactor = presenting ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width
         
        let yScaleFactor = presenting ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

        if presenting {
            notesView.transform = scaleTransform
            notesView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY
            )
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

        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: [],
            animations: {
                notesView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                notesView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                notesView.alpha = self.presenting ? 1.0 : 0.0
            }, completion: { finished in
                // tell our transitionContext object that we've finished animating
                
                transitionContext.completeTransition(true)
            }
        )
        
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
}
