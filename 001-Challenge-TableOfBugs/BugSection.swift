//
//  BugSection.swift
//  001-Challenge-TableOfBugs
//
//  Created by Andres Kwan on 5/29/17.
//  Copyright © 2017 Andres Kwan. All rights reserved.
//

import Foundation

struct BugSection {
    //an Enum is much better than a String to define the section
    // sectionName is not appropiate because the ScaryFactor provides 
    // an amount of fear not a name
    let amountOfFear: ScaryFactor
    var bugs = [ScaryBug]()
    
    init(amountOfFear: ScaryFactor) {
        self.amountOfFear = amountOfFear
    }
}
