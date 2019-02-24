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

    var editable : Bool = true

    @IBOutlet weak var noteLabel : UILabel!
    @IBOutlet weak var noteTextField : UITextField!

//    override func init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        editable = true
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let index = Int(arc4random_uniform(UInt32(RGB_VALUES.count)))
        let color = UIColor(
            red: RGB_VALUES[index].0 / 255.0,
            green: RGB_VALUES[index].1  / 255.0,
            blue: RGB_VALUES[index].2 / 255.0,
            alpha: 1.0)
        self.backgroundColor = color

        self.noteLabel.hidden = editable
        self.noteTextField.hidden = !editable

        let views = ["noteTextField" : noteTextField]
        let formatString = "|-10-[noteTextField]-10-|"

        let constraints = NSLayoutConstraint.constraintsWithVisualFormat(formatString, options: [], metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(constraints)
    }
}
