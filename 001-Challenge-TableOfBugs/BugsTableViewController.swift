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
        return bugSections[section].bugs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BugCell", for: indexPath)
        let bug = bugSections[indexPath.section].bugs[indexPath.row]
        cell.textLabel?.text = bug.name
        cell.detailTextLabel?.text = ScaryBug.scaryFactorToString(scaryFactor: bug.howScary)
        
        if let bugImage = bug.image {
            cell.imageView?.image = bugImage
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ScaryBug.scaryFactorToString(scaryFactor: bugSections[section].amountOfFear)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
