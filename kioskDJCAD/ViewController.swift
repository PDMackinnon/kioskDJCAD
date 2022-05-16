//
//  ViewController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var image1: NSImageView!
    @IBOutlet weak var image2: NSImageView!
    
    
    @IBOutlet weak var imgButton1: NSButton!
    @IBOutlet weak var imgButton2: NSButton!
    
    var studentName1 = "";
    var studentName2 = "";

    var webSiteUrlString1 = "";
    var webSiteUrlString2 = "";

    private let studentName1key = "firstSiteName";
    private let studentName2key = "secondSiteName";
    private let webSiteUrlString1key = "firstSiteURL";
    private let webSiteUrlString2key = "secondSiteURL";
    private let userImgFile1key = "firstFileURL";
    private let userImgFile2key = "secondFileURL";

    @IBOutlet weak var image1View: NSImageView!
    @IBOutlet weak var image2View: NSImageView!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = self.view.window {
            if (!(window.styleMask == NSWindow.StyleMask.fullScreen) ) {
                
                window.toggleFullScreen(self);
                
            };
        }

//        let home = FileManager.default.homeDirectoryForCurrentUser;
//        let fileTestURL = home.appendingPathComponent("Pictures/Pavilion.png")
//        print(fileTestURL);
        
//        let testIm: NSImage  = NSImage(contentsOf: fileTestURL)!;
//        image1.image = testIm;

//        image1.image = NSImage(contentsOfFile: " /Users/pdmackinnon/Documents/DJCAD Apps/Barcelona_Pavilion.tif");

        
//        print("image1: \(String(describing: image1.image))");
        
        imagesUpdate();
        
    }
    
    func imagesUpdate() {
        
        // load images for students if chosen in preferences
        
        let userDefaults = UserDefaults.standard;
        
        
        if let fileURL1 = userDefaults.url(forKey: userImgFile1key) {
            print(fileURL1.path);
            if FileManager.default.fileExists(atPath: fileURL1.path) {
                image1View.image = NSImage(contentsOf: fileURL1);
                
                imgButton1.image = NSImage(contentsOf: fileURL1);
                
            }//end if file exists
        }//end if let optional
        

        
        
        
        if let fileURL2 = userDefaults.url(forKey: userImgFile2key) {
            print(fileURL2.path);
            if FileManager.default.fileExists(atPath: fileURL2.path) {
                image2View.image = NSImage(contentsOf: fileURL2);
                imgButton2.image = NSImage(contentsOf: fileURL2);
                } //end if file exists
        } //end if let optional
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
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

