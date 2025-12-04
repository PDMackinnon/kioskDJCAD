//
//  AppDelegate.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    override init() {
            super.init()

        let transformer = FileURLToImageTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName("FileURLToImageTransformer"))
        
        let andTransformer = AndTransformer()
        ValueTransformer.setValueTransformer(andTransformer, forName: NSValueTransformerName("AndTransformer"))
        
        }

    func applicationWillFinishLaunching(_ notification: Notification) {
        UserDefaults.standard.set(false, forKey: "NSFullScreenMenuItemEverywhere")
    }
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let window = NSApp.windows.first {
            window.collectionBehavior.remove(.fullScreenPrimary)
            window.collectionBehavior.remove(.fullScreenAllowsTiling)
            
            window.collectionBehavior = .fullScreenNone
        }
        
  
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    
    func openPrefsDialog() {
        
    }
    
    @IBAction func enterKioskMode(_ sender: Any) {
        
        if let window = NSApp.mainWindow,
           let viewController = window.contentViewController as? ViewController {
            viewController.enterKioskMode(sender)
        }
    }
    
}

