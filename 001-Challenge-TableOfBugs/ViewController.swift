//
//  ViewController.swift
//  001-Challenge-TableOfBugs
//
//  Created by Andres Kwan on 5/29/17.
//  Copyright © 2017 Andres Kwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bugs = [ScaryBug]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bugs = ScaryBug.bugs()
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bugs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //obtain reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BugCell", for: indexPath)
        //obtain data to be placed in the cell
        let bug = bugs[indexPath.row]
        cell.textLabel?.text = bug.name
        cell.detailTextLabel?.text = ScaryBug.scaryFactorToString(scaryFactor: bug.howScary)
        if let imageView = cell.imageView, let bugImage = bug.image {
            imageView.image = bugImage
        }
        return cell
    }
}
