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
    
    //v4 Multiple sections
    private func setBugSections() {
        // TODO: - TODO - I need to enumerate an enum
        // so I could append to the array with the appropiate index value
        // https://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
        
        for fearValue in 0 ..< ScaryFactor.TotalFactors.rawValue {
            bugSections.append(BugSection(amountOfFear: ScaryFactor(rawValue: fearValue)!))
        }
        
        for bug in ScaryBug.bugs() {
            bugSections[bug.howScary.rawValue].bugs.append(bug)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - TODO - set the bugSections array
        setBugSections()
        //v2 - ViewController instead of TableViewController
//        automaticallyAdjustsScrollViewInsets = false
        //v5 - Delete row by tapping Edit button
        navigationItem.rightBarButtonItem = editButtonItem
        //v6
        tableView.allowsSelectionDuringEditing = true
        
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

    //v4 Multiple sections
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let adjustment = isEditing ? 1 : 0
        // TODO: - TODO - validate for adding a new row per section
        return bugSections[section].bugs.count + adjustment
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell
        
        if indexPath.row >= bugSections[indexPath.section].bugs.count && isEditing{
            // We are providing a cell to allow to add a new cell
            // we are reusing a cell so the image must be set. should be nil
            cell = tableView.dequeueReusableCell(withIdentifier: "NewRowCell", for: indexPath)
            cell.textLabel?.text = "Add New Bug"
            cell.detailTextLabel?.text = nil
            cell.imageView?.image = nil
        } else {
            let bug = bugSections[indexPath.section].bugs[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "BugCell", for: indexPath)
            //v7
            if let bugCell = cell as? ScaryBugCell {
                bugCell.bugNameLabel?.text = bug.name
                if bug.howScary.rawValue > ScaryFactor.AverageScary.rawValue {
                    bugCell.howScaryImageView.image = UIImage(named: "shockedface2_full")
                } else {
                    bugCell.howScaryImageView.image = UIImage(named: "shockedface2_empty")
                }
                
                guard let imageView = bugCell.bugImageView else {
                    return cell
                }
                if let bugImage = bug.image {
                    imageView.image = bugImage
                } else {
                    imageView.image = nil
                }
            }
        }
        return cell
    }

    //v4 Multiple sections
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return ScaryBug.scaryFactorToString(scaryFactor: bugSections[section].amountOfFear)
    }
    
    override func setEditing(_ editing: Bool,
                             animated: Bool) {
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
    //v5 Delete Rows
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bugSections[indexPath.section].bugs.remove(at: indexPath.row)
            //v5 - can be used here but is a bad UX
            //   - no animation
            //tableView.reloadData()
            //v5 - with animation better UX
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            let newBug = ScaryBug(withName: "New Name",
                                  imageName: nil,
                                  howScary: .QuiteScary)
            
//            var bugSection = bugSections[indexPath.section]
//            bugSection.bugs.append(newBug)
            bugSections[indexPath.section].bugs.append(newBug)
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
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row >= bugSections[indexPath.section].bugs.count {
            return .insert
        }
        return .delete
    }
    
    //enable/disable selection taped row
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if isEditing && indexPath.row < bugSections[indexPath.section].bugs.count {
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row >= bugSections[indexPath.section].bugs.count && isEditing {
                 self.tableView(tableView,
                           commit: .insert,
                           forRowAt: indexPath)
        }
    }
    
    //--------------Moving Rows-----------------
    //as Delegate - used to identify rows that can be moved
    //when is tapped edit.
    override func tableView(_ tableView: UITableView,
                            canMoveRowAt indexPath: IndexPath) -> Bool {
        if isEditing && indexPath.row >= bugSections[indexPath.section].bugs.count {
            return false
        }
        return true
    }
    
    /*update model with movement of data
     move rows to different sections is possible 
     add logic to prevent to move rows to a different section.
    */
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        if isEditing && sourceIndexPath.row != destinationIndexPath.row {
            let movedBug = bugSections[sourceIndexPath.section].bugs[sourceIndexPath.row]
            bugSections[sourceIndexPath.section].bugs.remove(at: sourceIndexPath.row)
            bugSections[destinationIndexPath.section].bugs.insert(movedBug,
                                                             at: destinationIndexPath.row)
        }
    }
    
    /*
     I need to identify if sections are different so,
     I could avoid last row moving when trying to insert from
     another section
     */
    override func tableView(_ tableView: UITableView,
                            targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                            toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        let proposedSection = proposedDestinationIndexPath.section
        let proposedRow = proposedDestinationIndexPath.row
        let sourceSection = sourceIndexPath.section
        let sourceRow = sourceIndexPath.row
        
        //valid when proposedSection == sourceSection 
        if proposedSection == sourceSection {
            if isEditing && proposedRow >= bugSections[proposedSection].bugs.count {
                return IndexPath(item: bugSections[proposedSection].bugs.count-1,
                                 section: proposedSection)
            }
        }
        return proposedDestinationIndexPath
    }
}


