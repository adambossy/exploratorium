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
    @IBOutlet weak var titleTextFieldBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        graphView.nodeCreatedDelegate = self
    }

    func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()

        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.titleTextFieldBottomConstraint.constant = -1 * keyboardFrame.size.height
        })
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
        textField.text = ""
        textField.hidden = true
        textField.endEditing(true)
        graphView.becomeFirstResponder()
        graphView.setNeedsDisplay()
        graphView.userInteractionEnabled = true
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

