//
//  ViewController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = self.view.window {
            if (!window.isZoomed) {
//                window.zoom(self);
                
                window.toggleFullScreen(self);
                
            };
        }

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
        print("prapere for segue \(segue.identifier!)");
        let dest = segue.destinationController as! webViewController03;
        
        if (segue.identifier == "first") {
            dest.destURLString = "https://www.vilmasaarelaart.com/";

        }
        else {
            dest.destURLString = "https://www.artstation.com/basiaszymiczek";

        }
        
        
        
    }
    

}

