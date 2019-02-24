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
    var data: [String]!
    @IBOutlet weak var navigationBar : UINavigationBar!

    required init?(coder aDecoder: NSCoder) {
        data = ["Placeholder!"]
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        navigationBar.topItem?.title = node.title
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return data.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : NoteCell = tableView.dequeueReusableCellWithIdentifier( "NoteCell", forIndexPath: indexPath) as! NoteCell
        
        // Configure the cell...
        cell.noteLabel.text = data[indexPath.row]

        return cell
    }

    // ***
    // MARK: Note adding and animation
    
    func animate(maybeCell: UITableViewCell?) {
        if let cell = maybeCell {
            let targetFrame = cell.frame
            cell.frame = CGRectMake(self.tableView.frame.width / 2, cell.frame.origin.y, 1, 1)
            UIView.animateWithDuration(1.0) {
                cell.frame = targetFrame
            }
        }
    }
    
    @IBAction func addNote() {
        data.append("New row!")
        self.tableView.reloadData()
        
        let newCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: data.count - 1, inSection: 0))
        self.animate(newCell)
//        let numRows = tableView.numberOfRowsInSection(1) // Only 1 section. Okay to hard-code
//        let indexPath = NSIndexPath(forRow: numRows, inSection: 1)
//        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
//        self.animate()
    }
}