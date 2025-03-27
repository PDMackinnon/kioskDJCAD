//
//  AppDelegate.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var context:NSManagedObjectContext

    override init() {
        
        self.context = DataManager.shared.managedObjectContext

        
        super.init()

        let transformer = FileURLToImageTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName("FileURLToImageTransformer"))
        
        let andTransformer = AndTransformer()
        ValueTransformer.setValueTransformer(andTransformer, forName: NSValueTransformerName("AndTransformer"))
        
        
        }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
  
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    
    func openPrefsDialog() {
        
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.

        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }
    
    
}

