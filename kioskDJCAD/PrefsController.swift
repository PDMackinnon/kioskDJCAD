//
//  PrefsController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class PrefsController: NSViewController {
    
    
    private let userImgFilekeys = ["fileURL00","fileURL01","fileURL02","fileURL03","fileURL04","fileURL05","fileURL06","fileURL07"];

    private let userImgFile1key = "firstFileURL";
    private let userImgFile2key = "secondFileURL";
    

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

    
    
    @IBAction func fileDialog(_ sender: NSButton) {
        let userDefaults = UserDefaults.standard;
        let tag = sender.tag
        
        let p = NSOpenPanel();
        p.begin(completionHandler: {(r) -> Void in
            if r == NSApplication.ModalResponse.OK {
                let tempFileURL = p.url ?? URL(fileURLWithPath: "dunno");
                
                userDefaults.set(tempFileURL, forKey:self.userImgFilekeys[tag]);
                print(self.userImgFilekeys[tag])
            }
        })
    }
    
    
//    @IBAction func fileDialog1(_ sender: NSButton) {
//        let userDefaults = UserDefaults.standard;
//        
//        let p = NSOpenPanel();
//        p.begin(completionHandler: {(r) -> Void in
//            if r == NSApplication.ModalResponse.OK {
//                let tempFileURL = p.url ?? URL(fileURLWithPath: "dunno");
//                
//                userDefaults.set(tempFileURL, forKey:self.userImgFile1key);
//            }
//        })
//    }
//    
//    @IBAction func fileDialog2(_ sender: NSButton) {
//        let userDefaults = UserDefaults.standard;
//        
//        let p = NSOpenPanel();
//        p.begin(completionHandler: {(r) -> Void in
//            if r == NSApplication.ModalResponse.OK {
//                let tempFileURL = p.url ?? URL(fileURLWithPath: "dunno");
//                
//                userDefaults.set(tempFileURL, forKey:self.userImgFile2key);
//            }
//        })
//    }
//    
    
}
