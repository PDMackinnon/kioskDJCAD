//
//  PrefsController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class PrefsController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func doneEditOK(_ sender: NSButton) {
        if let window = self.view.window {
            
            window.makeFirstResponder(sender);

            window.close();
            
            
        }
        
        
        print("done");
        
    }
}
