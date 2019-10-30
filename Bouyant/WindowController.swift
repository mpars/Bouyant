//
//  WindowController.swift
//  Bouyant
//
//  Created by mark on 25/09/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shouldCascadeWindows = true
        
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.isMovableByWindowBackground = true
    }

}
