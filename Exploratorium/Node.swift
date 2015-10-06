//
//  Node.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/27/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import Foundation
import UIKit

class Node : Hashable {
    
    let x : CGFloat
    let y : CGFloat
    var title: String!
    let color : UIColor
    
    init(x: CGFloat, y: CGFloat, title: String?, color: UIColor) {
        self.x = x
        self.y = y
        self.title = title
        self.color = color
    }

    var hashValue: Int {
        return Int(x * y) // Not perfect :|
    }
}

func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.x == rhs.x &&
        lhs.y == rhs.y &&
        lhs.title == rhs.title &&
        lhs.color == rhs.color;
}