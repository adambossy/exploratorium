//
//  DismissSegue.swift
//  Exploratorium
//
//  Created by Adam Bossy on 10/21/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class DismissSegue : UIStoryboardSegue {

    override func perform() {
        sourceViewController.presentingViewController??.dismissViewControllerAnimated(true, completion: nil)
    }
}
