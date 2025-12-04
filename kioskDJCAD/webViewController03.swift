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
        
        print("WebVC view frame: \(self.view.frame)")

        
        /*
        
        if let window = self.view.window {
            if (!window.isZoomed) {
                window.zoom(self);
            };
            

            if (!(window.styleMask == NSWindow.StyleMask.fullScreen) ) {

                window.toggleFullScreen(self);

            };
        }

        */
        
    }
    
//    var fullscreenManager: FullscreenWindowManager!

    
    var destURLString = "";

    @IBOutlet weak var theWebView: WKWebView!
   
    @IBOutlet weak var theCloseButton: NSButton!
    
    @IBAction func reloadPage(_ sender: NSButton) {
        print("reload ?");
        
        loadWebPage();

    }
    
    
    @IBAction func refreshPage(_ sender: NSButton) {
        theWebView.reload();

        
    }
    
    @IBAction func closeModal(_ sender: NSButton) {
        
        FullscreenWindowManager.shared.dismissFullscreenWindow()
        
//        FullscreenWindowManager.shared.presentFullscreenViewController(webVC)


        
//        if let window = self.view.window {
//            window.close();
//        }
        
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        //go back in the browser history
        
        theWebView.goBack()
    }
    
    
    
    
    


    
    override func viewDidLayout() {
        super.viewDidLayout()
        self.view.frame = self.view.superview?.bounds ?? .zero
    }


    
    func loadWebPage() {
        let tempStr = theWebView?.url?.absoluteString ?? "not known..."
        print("hello website 1 \(tempStr)");
        
        print("we are going to : \(destURLString)");
        
        guard let u = URL(string: destURLString) else { return };
        
        
        let r = URLRequest(url: u);
        
        theWebView.load(r);
        
        let tempStr2 = theWebView?.url?.absoluteString ?? "not known..."
        print("hello website 1 \(tempStr2)");
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
        //test
        //TODO make this conditional on user preferences
//        theCloseButton.removeFromSuperview();

        loadWebPage();
        
        
//        var URLRequest: r = URLRequest();
//        theWebView.load(r)
    }
    
}
