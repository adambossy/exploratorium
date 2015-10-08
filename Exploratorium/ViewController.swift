//
//  ViewController.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/27/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GraphViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var graphView: GraphView?
    @IBOutlet weak var titleTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        graphView!.titleDelegate = self
    }

    func editTitle() { // callback
        titleTextField!.hidden = false
        titleTextField!.becomeFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let nodeView = graphView!.newestNodeView {
            nodeView.title = textField.text
        }
        graphView!.setNeedsDisplay()
        graphView!.userInteractionEnabled = true
        graphView!.becomeFirstResponder()
        textField.text = ""
        textField.hidden = true
        return false
    }
}

