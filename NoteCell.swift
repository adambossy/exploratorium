//
//  NoteCell.swift
//  Exploratorium
//
//  Created by Adam Bossy on 10/22/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class NoteCell : UITableViewCell {

    @IBOutlet weak var styleView : UIView!
    @IBOutlet weak var noteLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.styleView.layer.cornerRadius = 10
        self.styleView.clipsToBounds = true

        let views = ["styleView" : styleView]
        let formatString = "|-10-[styleView]-10-|"

        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(formatString, options:nil , metrics: nil, views: views)

        NSLayoutConstraint.activateConstraints(constraints)
    }
}
