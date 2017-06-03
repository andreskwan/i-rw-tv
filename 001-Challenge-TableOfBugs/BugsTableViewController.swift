//
//  BugsTableViewController.swift
//  001-Challenge-TableOfBugs
//
//  Created by Andres Kwan on 5/29/17.
//  Copyright © 2017 Andres Kwan. All rights reserved.
//

import UIKit

class BugsTableViewController: UITableViewController {
    
    var bugSections = [BugSection]()
    
    private func setBugSections() {
        // TODO: - TODO - I need to enumerate an enum
        // so I could append to the array with the appropiate index value
        // https://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
        
        bugSections.append(BugSection(amountOfFear: .Aiiiiieeeee))
        bugSections.append(BugSection(amountOfFear: .Aiiiiieeeee))
        bugSections.append(BugSection(amountOfFear: .Aiiiiieeeee))
        bugSections.append(BugSection(amountOfFear: .Aiiiiieeeee))
        bugSections.append(BugSection(amountOfFear: .Aiiiiieeeee))
        
        bugSections[ScaryFactor.Aiiiiieeeee.rawValue] = BugSection(amountOfFear: .Aiiiiieeeee)
        bugSections[ScaryFactor.AverageScary.rawValue] = BugSection(amountOfFear: .AverageScary)
        bugSections[ScaryFactor.NotScary.rawValue] = BugSection(amountOfFear: .NotScary)
        bugSections[ScaryFactor.QuiteScary.rawValue] = BugSection(amountOfFear: .QuiteScary)
        bugSections[ScaryFactor.ALittleScary.rawValue] = BugSection(amountOfFear: .ALittleScary)
        
        for bug in ScaryBug.bugs() {
            bugSections[bug.howScary.rawValue].bugs.append(bug)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - TODO - set the bugSections array
        setBugSections()
        navigationItem.rightBarButtonItem = editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // TODO: - TODO - count the enum
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return bugSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let adjustment = isEditing ? 1 : 0
        // TODO: - TODO - validate for adding a new row per section
        return bugSections[section].bugs.count + adjustment
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BugCell", for: indexPath)
        
        //>= because equals means indexPath.count == bugs.count + 1
        if indexPath.row >= bugSections[indexPath.section].bugs.count {
            // We are providing a cell to allow to add a new cell
            // we are reusing a cell so the image must be set. should be nil
            cell.textLabel?.text = "Add New Bug"
            cell.detailTextLabel?.text = nil
            cell.imageView?.image = nil
        } else {
            let bug = bugSections[indexPath.section].bugs[indexPath.row]
            cell.textLabel?.text = bug.name
            cell.detailTextLabel?.text = ScaryBug.scaryFactorToString(scaryFactor: bug.howScary)
            
            if let bugImage = bug.image {
                cell.imageView?.image = bugImage
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ScaryBug.scaryFactorToString(scaryFactor: bugSections[section].amountOfFear)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // TODO: - TODO - what happens if I remove this line?
        //Goal: set "isEditing" before evaluate isEditing - is inherited and write protected
        super.setEditing(editing, animated: animated)
        if isEditing {
            //batch insertions
            //Goal: Add a new row at the end of each section
            tableView.beginUpdates()
            for (sectionIndex, section) in bugSections.enumerated() {
                
                let indexPath = IndexPath(row: section.bugs.count, section: sectionIndex)
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
            //Goal: set "isEditing" before evaluate isEditing
            //is not needed because of super.setEditing isEditing is inherited property
            //            tableView.setEditing(true, animated: true)
        } else {
            
            //Goal: Delete added rows (for adding a new row) to each section
            tableView.beginUpdates()
            for (sectionIndex, section) in bugSections.enumerated() {
                let indexPath = IndexPath(row: section.bugs.count, section: sectionIndex)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
            //is not needed because of super.setEditing isEditing is inherited property
            //            tableView.setEditing(false, animated: true)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bugSections[indexPath.section].bugs.remove(at: indexPath.row)
            //tableView.reloadData() can be used here but is a bad UX
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            let newBug = ScaryBug(withName: "New Name",
                                  imageName: nil,
                                  howScary: .QuiteScary)
            
            var bugSection = bugSections[indexPath.section]
            bugSection.bugs.append(newBug)
            tableView.insertRows(at: [indexPath],
                                 with: .automatic)
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let bugSection = bugSections[indexPath.section]
        if indexPath.row >= bugSection.bugs.count {
            return .insert
        }
        return .delete
    }
}


