//
//  GraphViewController.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/27/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, UITextFieldDelegate, NodeTapDelegate, NodeCreatedDelegate, UIViewControllerTransitioningDelegate {

    let notesTransitionAnimator = NotesTransitionAnimator()
    
    var selectedNode: NodeView?

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.nodeCreatedDelegate = self
    }

    // we override this method to manage what style status bar is shown
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.presentingViewController == nil ? UIStatusBarStyle.Default : UIStatusBarStyle.LightContent
    }

    // ***
    // MARK: UIViewControllerTransitioningDelegate methods
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let n = selectedNode {
            notesTransitionAnimator.originFrame = n.superview!.convertRect(n.frame, toView: nil)
        }
        notesTransitionAnimator.presenting = true
        return notesTransitionAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        notesTransitionAnimator.presenting = false
        return notesTransitionAnimator
    }

    // ***
    // MARK: Title editing
    
    func nodeCreated(#node: NodeView) {
        node.delegate = self
        titleTextField.hidden = false
        titleTextField.becomeFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let nodeView = graphView!.newestNodeView {
            nodeView.title = textField.text
        }
        graphView.setNeedsDisplay()
        graphView.userInteractionEnabled = true
        graphView.becomeFirstResponder()
        textField.text = ""
        textField.hidden = true
        return false
    }

    // ***
    // MARK: Node tapping & view controller transition
    
    func nodeTapped(node: NodeView) {
        selectedNode = node
        performSegueWithIdentifier("ShowNotes", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowNotes" {
            if let n = selectedNode {
                let notesViewController = segue.destinationViewController as! NotesViewController
                notesViewController.node = selectedNode
                notesViewController.transitioningDelegate = self
            }
        }
    }
}

//extension GraphViewController: UIViewControllerTransitioningDelegate {
//    func animateTransition() {
//
//    }
//
//    func transitionDuration () {
//        return 0.5
//    }
//
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//    
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//        
//    }
//}


