//
//  webViewController01.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa
import WebKit

class webViewController01: NSViewController,WKUIDelegate {


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
        
        
        guard let u = URL(string: "https://www.deviantart.com/maxasabin/art/My-town-912906370") else { return };
        
        
        let r = URLRequest(url: u);
        
        theWebView.load(r);
        
        let tempStr2 = theWebView?.url?.absoluteString ?? "not known..."
        print("hello website 1 \(tempStr2)");
        
        
        
        
//        var URLRequest: r = URLRequest();
//        theWebView.load(r)
    }
    
}
