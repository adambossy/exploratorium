//
//  GraphViewController.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/27/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, UITextFieldDelegate, NodeTapDelegate, NodeCreatedDelegate, UIViewControllerTransitioningDelegate {

    let DEBUG = true
    let notesTransitionAnimator = NotesTransitionAnimator()

    var selectedNode: NodeView?

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleTextFieldBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        graphView.nodeCreatedDelegate = self
        
        if DEBUG {
            let color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            nodeTapped(node: NodeView(x: 0, y: 0, title: nil, color: color))
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.titleTextFieldBottomConstraint.constant = -1 * keyboardFrame.size.height
        })
    }

    // we override this method to manage what style status bar is shown
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.presentingViewController == nil ? UIStatusBarStyle.default : UIStatusBarStyle.lightContent
    }

    // ***
    // MARK: UIViewControllerTransitioningDelegate methods
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let n = selectedNode {
            notesTransitionAnimator.originFrame = n.superview!.convert(n.frame, to: nil)
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

    func nodeCreated(node: NodeView) {
        node.delegate = self
        titleTextField.isHidden = false
        titleTextField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nodeView = graphView!.newestNodeView {
            nodeView.title = textField.text
        }
        textField.text = ""
        textField.isHidden = true
        textField.endEditing(true)
        graphView.becomeFirstResponder()
        graphView.setNeedsDisplay()
        graphView.isUserInteractionEnabled = true
        return false
    }

    // ***
    // MARK: Node tapping & view controller transition

    func nodeTapped(node: NodeView) {
        selectedNode = node
        performSegue(withIdentifier: "ShowNotes", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNotes" {
            if let n = selectedNode {
                let notesViewController = segue.destination as! NotesViewController
                notesViewController.node = n
                notesViewController.transitioningDelegate = self
            }
        }
    }
}

