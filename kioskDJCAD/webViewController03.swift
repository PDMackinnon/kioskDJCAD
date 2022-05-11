//
//  webViewController01.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa
import WebKit

class webViewController03: NSViewController,WKUIDelegate {

    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = self.view.window {
            if (!window.isZoomed) {
                window.zoom(self);
            };
        }

    }
    
    
    
    var destURLString = "";

    @IBOutlet weak var reloadButton: NSButton!
    @IBOutlet weak var theWebView: WKWebView!
   
    
    @IBAction func reloadPage(_ sender: NSButton) {
        print("reload ?");
        
        let tempStr = theWebView?.url?.absoluteString ?? "not known..."
        print("hello website 1 \(tempStr)");
        
        
        theWebView.reload();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let tempStr = theWebView?.url?.absoluteString ?? "not known..."
        print("hello website 1 \(tempStr)");
        
        print("we are going to : \(destURLString)");
        
        guard let u = URL(string: destURLString) else { return };
        
        
        let r = URLRequest(url: u);
        
        theWebView.load(r);
        
        let tempStr2 = theWebView?.url?.absoluteString ?? "not known..."
        print("hello website 1 \(tempStr2)");
        
        
        
        
//        var URLRequest: r = URLRequest();
//        theWebView.load(r)
    }
    
}
