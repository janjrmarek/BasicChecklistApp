//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Jan Marek on 2017-11-17.
//  Copyright © 2017 MonnioTechnologies. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
