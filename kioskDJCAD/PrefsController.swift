//
//  PrefsController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class PrefsController: NSViewController {
    

    @objc dynamic var context:NSManagedObjectContext {
        return  DataManager.shared.managedObjectContext
        
    }
    

    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var arrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
//test only:
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        10
//    }
    
    
    
    @IBAction func doneEditOK(_ sender: NSButton) {
        if let window = self.view.window {
            
            window.makeFirstResponder(sender);

            window.close();
        }
        
        print("done");
        DataManager.shared.saveContext()
    }

    

    @IBAction func editDialog(_ sender: NSButton) {
        
        
        
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destinationController as? PrefsDetailViewController {
            if let button = sender as? NSButton {
                let row = tableView.row(for: button)
                if row >= 0, let items = arrayController.arrangedObjects as? [LaunchItem], row < items.count {
                    //edit an existing item
                    detailVC.launchItem = items[row]
                } else {
                    // create a new item in this case
//                    let newItem = NSEntityDescription.insertNewObject(forEntityName: "LaunchItem", into: context)
                    let newItem = LaunchItem(context: context)
                    detailVC.launchItem = newItem
                    detailVC.isNewItem = true
                }
            }
        }// end if
    }
    

    
}// end class pref controller
