//
//  TableTestVC.swift
//  kioskDJCAD
//
//  Created by admin on 17/03/2025.
//

import Cocoa

class TableTestVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        10
    }
    
}
