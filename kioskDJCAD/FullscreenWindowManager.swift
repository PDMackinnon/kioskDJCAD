//
//  FullscreenWindowManager.swift
//  kioskDJCAD
//
//  Created by admin on 30/04/2025.
//

import Foundation
import Cocoa




class FullscreenWindowManager {
    
    static let shared = FullscreenWindowManager()

    
    private var fullscreenWindow: NSWindow?
    
    /// Presents a view controller in a fullscreen-style window over the current screen.
    func presentFullscreenViewController(_ viewController: NSViewController) {
        guard fullscreenWindow == nil else { return }  // prevent duplicates

        guard let screen = NSScreen.main else { return }
        let screenFrame = screen.frame

        let window = NSWindow(contentRect: screenFrame,
                              styleMask: [.borderless],
                              backing: .buffered,
                              defer: false)
        window.isReleasedWhenClosed = false
        window.contentViewController = viewController
        window.level = .mainMenu + 2
        
        window.setFrame(screenFrame, display: true)

        
        window.makeKeyAndOrderFront(nil)
        
        print("Presented window frame: \(window.frame)")

        
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        fullscreenWindow = window
    }
    
    /// Dismisses the fullscreen-style window if present.
    func dismissFullscreenWindow() {
        fullscreenWindow?.orderOut(nil)
        fullscreenWindow = nil
    }
}
