//
//  EditTableViewController.swift
//  001-Challenge-TableOfBugs
//
//  Created by Andres Kwan on 6/17/17.
//  Copyright © 2017 Andres Kwan. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {

    @IBOutlet weak var editBugImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var NameTextField: UITextField!
    
    var bugToEdit : ScaryBug?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        NameTextField.delegate = self
        NameTextField.attributedPlaceholder = NSAttributedString(string: "Ponete algo ome.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let bug = bugToEdit {
            editBugImage.image = bug.image
            ratingLabel.text = ScaryBug.scaryFactorToString(scaryFactor: bug.howScary)
            NameTextField.text = bug.name
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        bugToEdit?.image = editBugImage.image
        bugToEdit?.name = NameTextField.text!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension EditTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
