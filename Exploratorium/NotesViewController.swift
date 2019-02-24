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
        tableView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        navigationBar.topItem?.title = node.title
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {

        return data.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NoteCell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        
        // Configure the cell...
        cell.noteLabel.text = data[indexPath.row]

        return cell
    }

    // ***
    // MARK: Note adding and animation
    
    func animate(maybeCell: UITableViewCell?) {
        if let cell = maybeCell {
            let targetFrame = cell.frame
            cell.frame = CGRect(x: self.tableView.frame.width / 2, y: cell.frame.origin.y, width: 1, height: 1)
            UIView.animate(withDuration: 1.0) {
                cell.frame = targetFrame
            }
        }
    }
    
    @IBAction func addNote() {
        data.append("New row!")
        self.tableView.reloadData()
        
        let newCell = self.tableView.cellForRow(at: NSIndexPath(row: data.count - 1, section: 0) as IndexPath)
        self.animate(maybeCell: newCell)
//        let numRows = tableView.numberOfRowsInSection(1) // Only 1 section. Okay to hard-code
//        let indexPath = NSIndexPath(forRow: numRows, inSection: 1)
//        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
//        self.animate()
    }
}
