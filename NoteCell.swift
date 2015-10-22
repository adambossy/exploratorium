//
//  NoteCell.swift
//  Exploratorium
//
//  Created by Adam Bossy on 10/22/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class NoteCell : UITableViewCell {

    let RGB_VALUES : [(CGFloat, CGFloat, CGFloat)] = [
        (155, 196, 226),
    ]

    @IBOutlet weak var styleView : UIView!
    @IBOutlet weak var noteLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.styleView.layer.cornerRadius = 10
        self.styleView.clipsToBounds = true

        let index = Int(arc4random_uniform(UInt32(RGB_VALUES.count)))
        let color = UIColor(
            red: RGB_VALUES[index].0 / 255.0,
            green: RGB_VALUES[index].1  / 255.0,
            blue: RGB_VALUES[index].2 / 255.0,
            alpha: 1.0)
        self.styleView.backgroundColor = color
        self.styleView.layer.borderColor = UIColor.blackColor().CGColor
        self.styleView.layer.borderWidth = 4

        let views = ["styleView" : styleView]
        let formatString = "|-10-[styleView]-10-|"

        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(formatString, options:nil , metrics: nil, views: views)

        NSLayoutConstraint.activateConstraints(constraints)
    }
}
