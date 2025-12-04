//
//  codescratch.swift
//  kioskDJCAD
//
//  Created by admin on 30/04/2025.
//

import Foundation

class ViewController: NSViewController {

    var exitPressStartTime: Date?

    @IBAction func hiddenExitButtonDown(_ sender: NSButton) {
        exitPressStartTime = Date()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let start = self?.exitPressStartTime else { return }
            let heldDuration = Date().timeIntervalSince(start)

            if heldDuration >= 3.0 {
                self?.revertToNormalMode()
            }
        }
    }

    @IBAction func hiddenExitButtonUp(_ sender: NSButton) {
        exitPressStartTime = nil
    }

    func revertToNormalMode() {
        if let window = self.view.window {
            // Restore normal window style
            window.styleMask = [.titled, .closable, .resizable, .miniaturizable]
            window.level = .normal
            window.setFrame(NSScreen.main?.visibleFrame ?? .zero, display: true, animate: true)

            // Optional: make sure the menu bar becomes visible again
            NSApp.setActivationPolicy(.regular)
        }
    }
}


//----------

class ViewController: NSViewController {
    
    private var exitPressTimer: Timer?
    
    @IBAction func hiddenExitPressed(_ sender: NSButton) {
        // Start timer when mouse down
        exitPressTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            self?.exitKioskMode()
        }
    }

    @IBAction func hiddenExitReleased(_ sender: NSButton) {
        // Cancel timer if released early
        exitPressTimer?.invalidate()
        exitPressTimer = nil
    }

    func exitKioskMode() {
        guard let window = self.view.window else { return }

        // Restore window style and level
        window.styleMask = [.titled, .closable, .resizable, .miniaturizable]
        window.level = .normal
        window.standardWindowButton(.closeButton)?.isHidden = false
        window.standardWindowButton(.miniaturizeButton)?.isHidden = false
        window.standardWindowButton(.zoomButton)?.isHidden = false
        window.setFrame(NSScreen.main?.frame ?? NSRect(x: 100, y: 100, width: 800, height: 600), display: true)
        
        // Optional: make menus visible again or update state if needed
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        
        // Skip kiosk mode if we're in dev/exit state
        if !UserDefaults.standard.bool(forKey: "kioskEnabled") {
            return
        }

        // Kiosk presentation logic here...
    }
}



//--------
@IBOutlet weak var hiddenExitButton: NSButton!

override func viewDidLoad() {
    super.viewDidLoad()
    hiddenExitButton.target = self
    hiddenExitButton.action = #selector(hiddenExitPressed(_:))
    hiddenExitButton.sendAction(on: [.leftMouseDown])
    
    // Add release tracking
    hiddenExitButton.sendAction(on: [.leftMouseUp])
}
//------

override func viewDidLoad() {
    super.viewDidLoad()
    
    let pressRecognizer = NSPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    pressRecognizer.minimumPressDuration = 3.0  // seconds
    hiddenExitView.addGestureRecognizer(pressRecognizer)
}


//------

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

        // Optional: hide the menu bar again if needed
        NSApp.setActivationPolicy(.accessory)
    }
}

@IBAction func enterKioskMode(_ sender: Any?) {
    if let window = NSApp.mainWindow,
       let viewController = window.contentViewController as? ViewController {
        viewController.enterKioskMode(sender)
    }
}

//---
func applicationDidFinishLaunching(_ notification: Notification) {
    if let window = NSApp.windows.first {
        window.collectionBehavior.remove(.fullScreenPrimary)
        window.collectionBehavior.remove(.fullScreenAllowsTiling)
    }
}

override func viewDidAppear() {
    super.viewDidAppear()

    if let window = self.view.window {
        // Disable tiling and fullscreen behaviors
        window.collectionBehavior.remove(.fullScreenPrimary)
        window.collectionBehavior.remove(.fullScreenAllowsTiling)

        // Optional: confirm applied
        print("Collection behavior after update: \(window.collectionBehavior)")
    }
}

//--
