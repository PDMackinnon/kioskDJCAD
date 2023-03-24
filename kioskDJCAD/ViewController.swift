//
//  ViewController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class ViewController: NSViewController {
    

    @IBOutlet weak var spacerTLeft: NSView!
    @IBOutlet weak var spacerTRight: NSView!
    @IBOutlet weak var spacerBLeft: NSView!
    @IBOutlet weak var spacerBRight: NSView!
    
    
    @IBOutlet weak var imgButton1: NSButton!
    @IBOutlet weak var imgButton2: NSButton!
    @IBOutlet weak var imgButton3: NSButton!
    
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

    
    
    
    private let webSiteUrlKeys = ["siteURL00","siteURL01","siteURL02","siteURL03","siteURL04","siteURL05",]
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = self.view.window {
            if (!(window.styleMask == NSWindow.StyleMask.fullScreen) ) {
                
                window.toggleFullScreen(self);
                
            };
        }
        
        
    }//end view did appear
    
    /*
     
     // Set the boolean value
     let defaults = UserDefaults.standard
     defaults.set(true, forKey: "isHidden")

     // Bind the boolean value to your NSView's hidden property using Cocoa bindings
     yourNSView.bind(NSBindingName(rawValue: "hidden"), to: defaults, withKeyPath: "isHidden", options: nil)
     
     */
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let transformer = ValueTransformer(forName: NSValueTransformerName(rawValue: "AndTransformer"))!
        print("transformer: \(transformer)")
        print("transformer.allowsReverseTransformation: \(String(describing: AndTransformer.allowsReverseTransformation))")
        print("transformer.transformedValueClass: \(String(describing: AndTransformer.transformedValueClass))")
        print("transformer.transformedValue([imgButton1,imgButton2,imgButton3]): \(String(describing: transformer.transformedValue([imgButton1.isHidden,imgButton2.isHidden,imgButton3.isHidden])))")
        
        // Do any additional setup after loading the view.
        
//        let bindingOptions = [NSBindingOption.valueTransformerName//: AndTransformer]
        
        
        //   let bindingOptions= [NSBindingOption.valueTransformerNameBindingOption: NSValueTransformerName.AndTransformerName]
        
      //  myTextField.bind(NSValueBinding, to: myObject, withKeyPath: "myValue", options: [NSValueTransformerNameBindingOption: "MyValueTransformer"])
        

        
//        spacerTLeft.bind(NSBindingName(rawValue: "hidden"), to:  [imgButton1,imgButton2,imgButton3], withKeyPath: "isHidden", options: [NSBindingOption.valueTransformerName:"AndTransformer"])
        
      //  spacerTLeft.bind(NSBindingName(rawValue: "hidden"), to: [imgButton1,imgButton2,imgButton3], withKeyPath: "hidden", options: bindingOptions)
        
        /*
         
         otherNSView2.bind(NSBindingName(rawValue: "hidden"), toObjects: [yourNSView, otherNSView1], withKeyPaths:["hidden", "hidden"], options:[bindingOptions])
         
         */
        
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        let userDefaults = UserDefaults.standard;
        
//        studentName1 = userDefaults.string(forKey: studentName1key) ?? "website1";
        webSiteUrlString1 = userDefaults.string(forKey: webSiteUrlString1key) ?? "https://www.dundee.ac.uk";
        
//        studentName2 = userDefaults.string(forKey: studentName2key) ?? "website2";
        webSiteUrlString2 = userDefaults.string(forKey: webSiteUrlString2key) ?? "https://www.dundee.ac.uk";
        
        guard
        let tag = (sender as? NSButton)?.tag
            else {return}
        
        
        
        let webSiteUrlString = userDefaults.string(forKey: webSiteUrlKeys[tag]) ?? "https://www.dundee.ac.uk";
        
        
        let notSet = "Not Set"
        print("prepare for segue \(segue.identifier ?? notSet)");
        
        let dest = segue.destinationController as! webViewController03;
        
        dest.destURLString = webSiteUrlString;

        
        
        
//        if (segue.identifier == "first") {
//
//            dest.destURLString = webSiteUrlString1;
//
//            //Test idea:
////            dest.theCloseButton.removeFromSuperview();
//        }
//        else {
//            // segue.identifier == "second"
//
//
//            dest.destURLString = webSiteUrlString2;
//
//        }
        
        
        
    }
    

}

