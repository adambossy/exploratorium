//
//  Graph.swift
//  Exploratorium
//
//  Created by Adam Bossy on 9/27/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import Foundation

class Graph {
    
    var adjList: [Node: [Node]]

    init() {
        adjList = [Node: [Node]]()
    }
    
    func add(node: Node) {
        adjList[node] = [Node]()
    }
}