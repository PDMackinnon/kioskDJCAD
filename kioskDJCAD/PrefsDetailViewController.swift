//
//  PrefsDetailViewController.swift
//  kioskDJCAD
//
//  Created by admin on 20/03/2025.
//

import Cocoa

class PrefsDetailViewController: NSViewController {
    
    @objc dynamic var context:NSManagedObjectContext {
        return  DataManager.shared.managedObjectContext
        
    }
    
    @IBOutlet weak var detailObjectController: NSObjectController!
    
    var launchItem:LaunchItem?
    var isNewItem: Bool = false
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
//        need to set up the object controller
        
        
        if let launchItem = launchItem {
            detailObjectController.content = launchItem  //we should have an existing or a new launch item to bind here
            
            print(String(describing: detailObjectController.content))
            
            
        }
        
        
        
        
        
        
    } // end view did load
    
    
    @IBAction func saveAndClose(_ sender: Any) {
        self.view.window?.makeFirstResponder(nil) // this should commit the current field edit
        
        print(String(describing: detailObjectController.content))

        
        do {
            try launchItem?.managedObjectContext?.save()
            dismiss(self)
        }
        catch {
            print("Error saving: \(error)")
        }
        DataManager.shared.saveContext()

    }
    
    @IBAction func cancelAndClose(_ sender: Any) {
        if isNewItem, let context = launchItem?.managedObjectContext {
            context.delete(launchItem!)
        }
        dismiss(self)
    }
    
    
    
    
    @IBAction func chooseImageFile(_ sender: NSButton) {
        
//        let tag = sender.tag
        
        let panel = NSOpenPanel();
        
        panel.allowedFileTypes = ["png","jpg","jpeg","gif","tiff"]
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        
        
        if panel.runModal() == .OK, let url = panel.url {
            //set the image file url as required
            // use core data
            
            if let objectController = detailObjectController,
               let lauchItem = objectController.content as? LaunchItem {
                lauchItem.imagePath = url.path  //store the file path in core data object
            }
            DataManager.shared.saveContext()
        }
        
        
    }
}
