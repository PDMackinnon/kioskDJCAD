//
//  ViewController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class ViewController: NSViewController {
    
    var studentName1 = "";
    var studentName2 = "";

    var webSiteUrlString1 = "";
    var webSiteUrlString2 = "";

    private let studentName1key = "firstSiteName";
    private let studentName2key = "secondSiteName";
    private let webSiteUrlString1key = "firstSiteURL";
    private let webSiteUrlString2key = "secondSiteURL";

    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = self.view.window {
            if (!(window.styleMask == NSWindow.StyleMask.fullScreen) ) {
                
                window.toggleFullScreen(self);
                
            };
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let userDefaults = UserDefaults.standard;
//
//        studentName1 = userDefaults.string(forKey: studentName1key) ?? "website1";
//        webSiteUrlString1 = userDefaults.string(forKey: webSiteUrlString1key) ?? "https://www.dundee.ac.uk";
//
//        studentName2 = userDefaults.string(forKey: studentName2key) ?? "website2";
//        webSiteUrlString2 = userDefaults.string(forKey: webSiteUrlString2key) ?? "https://www.dundee.ac.uk";
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        let userDefaults = UserDefaults.standard;
        
        studentName1 = userDefaults.string(forKey: studentName1key) ?? "website1";
        webSiteUrlString1 = userDefaults.string(forKey: webSiteUrlString1key) ?? "https://www.dundee.ac.uk";
        
        studentName2 = userDefaults.string(forKey: studentName2key) ?? "website2";
        webSiteUrlString2 = userDefaults.string(forKey: webSiteUrlString2key) ?? "https://www.dundee.ac.uk";
        
        print("student1 is \(studentName1)");
        print("website1 is \(webSiteUrlString1)");

        print("student2 is \(studentName2)");
        print("website2 is \(webSiteUrlString2)");
        
        print("prapere for segue \(segue.identifier!)");
        let dest = segue.destinationController as! webViewController03;
        
        if (segue.identifier == "first") {
            
            dest.destURLString = webSiteUrlString1;

        }
        else {
            // segue.identifier == "second"
            
            
            dest.destURLString = webSiteUrlString2;

        }
        
        
        
    }
    

}

