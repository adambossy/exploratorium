//
//  NotesViewController.swift
//  Exploratorium
//
//  Created by Adam Bossy on 10/8/15.
//  Copyright (c) 2015 Bossy Software. All rights reserved.
//

import UIKit

class NotesViewController : UITableViewController { //, UIViewControllerTransitioningDelegate {

    var node: NodeView! // NOTE: Ugh. It's hacky that the nodeView acts as the model.
    @IBOutlet weak var navigationBar : UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        navigationBar.topItem?.title = node.title
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier( "NoteCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        cell.textLabel!.text = "Section \(indexPath.section) Row \(indexPath.row)"

        return cell
    }
    
    // ***
    // UIViewControllerTransitioningDelegate
//    
//    
}