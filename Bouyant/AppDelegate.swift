//
//  AppDelegate.swift
//  Bouyant
//
//  Created by mark on 25/09/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // set up NSStatusItem
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)

        
        if let button = statusBarItem.button {
            //button.image = NSImage(named: ?)
            button.title = "{ }"
            button.target = self
            button.action = #selector(self.statusBarButtonClicked(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
    }
    
    
    @objc func statusBarButtonClicked(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == NSEvent.EventType.rightMouseUp {
            print("Right click")
        } else {
            print("Left click")
            NSApp.activate(ignoringOtherApps: true)
        }
    }

    
    
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    // Opens last opened document
    
    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        
        let documentController = NSDocumentController.shared
        
        if let mostRecentDocument = documentController.recentDocumentURLs.first {
            documentController.openDocument(withContentsOf: mostRecentDocument, display: true, completionHandler: { (document, documentWasAlreadyOpen, errorWhileOpening) in
                // Handle opened document or error here
            })
            return false
        } else {
            return true
        }
    }

}

