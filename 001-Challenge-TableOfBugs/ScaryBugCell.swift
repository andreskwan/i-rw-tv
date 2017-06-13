//
//  ScaryBugCell.swift
//  001-Challenge-TableOfBugs
//
//  Created by Andres Kwan on 6/11/17.
//  Copyright © 2017 Andres Kwan. All rights reserved.
//

import UIKit

//v7
class ScaryBugCell: UITableViewCell {

    @IBOutlet weak var bugImageView: UIImageView!
    @IBOutlet weak var bugNameLabel: UILabel!
    @IBOutlet weak var howScaryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
