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
        
        }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
  
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    
    func openPrefsDialog() {
        
    }
    
    
}

