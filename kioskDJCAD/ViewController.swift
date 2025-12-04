//
//  ViewController.swift
//  kioskDJCAD
//
//  Created by Paul MacKinnon on 11/05/2022.
//

import Cocoa

class ViewController: NSViewController {
    
    var shouldForceFullscreen = true

//    @IBOutlet weak var hiddenBtn: NSButton!
    
    @IBOutlet weak var spacerTLeft: NSView!
    @IBOutlet weak var spacerTRight: NSView!
    @IBOutlet weak var spacerBLeft: NSView!
    @IBOutlet weak var spacerBRight: NSView!
    
    
    @IBOutlet weak var imgButton1: NSButton!
    @IBOutlet weak var imgButton2: NSButton!
    @IBOutlet weak var imgButton3: NSButton!
    
    private let webSiteUrlKeys = ["siteURL00","siteURL01","siteURL02","siteURL03","siteURL04","siteURL05",]
    
    private let externalOptionKeys = ["ext00","ext01","ext02","ext03","ext04","ext05",]
    

    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = self.view.window {
            // Disable tiling and fullscreen behaviors
            window.collectionBehavior.remove(.fullScreenPrimary)
            window.collectionBehavior.remove(.fullScreenAllowsTiling)

            // Optional: confirm applied
            print("Collection behavior after update: \(window.collectionBehavior)")
        }

        guard shouldForceFullscreen else {
            print("Skipping fullscreen setup")
            return
        }

        if let window = self.view.window {
            if window.styleMask.contains(.fullScreen) {
                window.toggleFullScreen(self)
            }

//            print(window.collectionBehavior.rawValue)
//
//            window.collectionBehavior.remove(.fullScreenPrimary)
//            window.collectionBehavior.remove(.fullScreenAllowsTiling)
//            print(window.collectionBehavior.rawValue)

            
            if let screen = NSScreen.main {
                let frame = screen.frame
                window.setFrame(frame, display: true)
                window.styleMask = [.borderless]
                window.level = .mainMenu + 1
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let transformer = ValueTransformer(forName: NSValueTransformerName(rawValue: "AndTransformer"))!
        print("transformer: \(transformer)")
        print("transformer.allowsReverseTransformation: \(String(describing: AndTransformer.allowsReverseTransformation))")
        print("transformer.transformedValueClass: \(String(describing: AndTransformer.transformedValueClass))")
        print("transformer.transformedValue([imgButton1,imgButton2,imgButton3]): \(String(describing: transformer.transformedValue([imgButton1.isHidden,imgButton2.isHidden,imgButton3.isHidden])))")
        
        // Do any additional setup after loading the view.

        let pressRecognizer = NSPressGestureRecognizer(target: self, action: #selector(hiddenExitTest(_:)))
        pressRecognizer.minimumPressDuration = 3.0  // seconds
        pressRecognizer.buttonMask = 2
//        hiddenBtn.addGestureRecognizer(pressRecognizer)
        
        self.view.addGestureRecognizer(pressRecognizer)
        
        
    } //end view did load

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        let userDefaults = UserDefaults.standard;
        
        
        guard
        let tag = (sender as? NSButton)?.tag
            else {return}
        
        
        
        let webSiteUrlString = userDefaults.string(forKey: webSiteUrlKeys[tag]) ?? "https://www.dundee.ac.uk";
        
        
        let notSet = "Not Set"
        print("prepare for segue \(segue.identifier ?? notSet)");
        
        let dest = segue.destinationController as! webViewController03;
        
        dest.destURLString = webSiteUrlString;

    }
    
    @IBAction func openWebView(_ sender: Any?) {
        let userDefaults = UserDefaults.standard
        
        guard
            let tag = (sender as? NSButton)?.tag
        else { return }
        
        let webSiteUrlString = userDefaults.string(forKey: webSiteUrlKeys[tag]) ?? "https://www.dundee.ac.uk"

        let storyboard = NSStoryboard(name: "Main", bundle: nil)

        guard let webVC = storyboard.instantiateController(withIdentifier: "webViewController03") as? webViewController03 else {
            return
        }

        webVC.destURLString = webSiteUrlString
        
        FullscreenWindowManager.shared.presentFullscreenViewController(webVC)

    }

    
    
    
    @IBAction func OpenInBrowser(_ sender: NSButton) {
            
        let userDefaults = UserDefaults.standard;
        
        
        guard
        let tag = (sender as? NSButton)?.tag
            else {return}
        
        
        
        let webSiteUrlString = userDefaults.string(forKey: webSiteUrlKeys[tag]) ?? "https://www.dundee.ac.uk";
        
        
        let extBrowser = userDefaults.bool(forKey: externalOptionKeys[tag])
        
        
        if (extBrowser) {
            
            print("Launcher got URL string: [\(webSiteUrlString)]")

            guard let url = URL(string: webSiteUrlString) else {return}
            
            let config = NSWorkspace.OpenConfiguration()
            config.promptsUserIfNeeded = false    // No extra UI
            
            
            NSWorkspace.shared.open(url, configuration: config);

            
        }
        else {
            openWebView(sender)

            
        }
    } //end func
    
    func revertToNormalMode() {
        
        shouldForceFullscreen = false

        
        if let window = self.view.window {
            // Restore normal window style
            window.styleMask = [.titled, .closable, .resizable, .miniaturizable]
            window.level = .normal
            window.setFrame(NSScreen.main?.visibleFrame ?? .zero, display: true, animate: true)
            
            window.standardWindowButton(.closeButton)?.isHidden = false
            window.standardWindowButton(.miniaturizeButton)?.isHidden = false
            window.standardWindowButton(.zoomButton)?.isHidden = true

            
            // Optional: make sure the menu bar becomes visible again
            NSApp.setActivationPolicy(.regular)
            
            //            print(window.collectionBehavior.rawValue)
            //
            //            window.collectionBehavior.remove(.fullScreenPrimary)
            //            window.collectionBehavior.remove(.fullScreenAllowsTiling)
            //            print(window.collectionBehavior.rawValue)
            
        }
    }

    @IBAction func hiddenExitTest(_ sender: Any) {

        revertToNormalMode()
    }
    
    @IBAction func enterKioskMode(_ sender: Any?) {
        shouldForceFullscreen = true

        if let screen = NSScreen.main,
           let window = self.view.window {
            let frame = screen.frame
            window.setFrame(frame, display: true)
            window.styleMask = [.borderless]
            window.level = .mainMenu + 1
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true


        }
    }
    


}// end class

