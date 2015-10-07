//
//  ViewController.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/27/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

enum State { case Scene, Title, Notes }

class ViewController: UIViewController, GraphSceneDelegate, UITextFieldDelegate {

    var state : State!

    @IBOutlet weak var scene: GraphScene?
    @IBOutlet weak var titleTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        state = State.Scene
        scene!.titleDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if state == State.Scene {
            // propagate
        } else {
            
        }
    }

    func editTitle() { // callback
        titleTextField!.hidden = false
        titleTextField!.becomeFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print(textField.text)
        if let nodeView = scene!.newestNodeView {
            nodeView.title = textField.text
        }
        scene!.setNeedsDisplay()
        scene!.becomeFirstResponder()
        textField.text = ""
        textField.hidden = true
        scene!.userInteractionEnabled = true
        return false
    }
}

