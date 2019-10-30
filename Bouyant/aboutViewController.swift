//
//  aboutViewController.swift
//  Bouyant
//
//  Created by mark on 07/10/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Cocoa

class aboutViewController: NSViewController {

    @IBOutlet var aboutTextView: NSTextView!
    @IBOutlet weak var iconImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        
        let attributedString = NSMutableAttributedString(string: "Bouyant is a plain text editor written in Swift.\n\nBouyant uses Highlightr and NSTextView-LineNumberView")
        let bouyantRange = NSRange(location: 0, length: 7)
        let bouyantUrl = URL(string: "https://github.com/mpars")!
        let highlightrRange = NSRange(location: 63, length: 10)
        let highlightrUrl = URL(string: "https://github.com/raspu/Highlightr")!
        let lineNumberRange = NSRange(location: 78, length:25)
        let lineNumberUrl = URL(string:"https://github.com/yichizhang/NSTextView-LineNumberView")!
        // set attributedString textColor for light/dark switch
        attributedString.setAttributes([.foregroundColor : NSColor.textColor], range: NSRange(location: 0, length: attributedString.length))
        attributedString.setAttributes([.link: bouyantUrl], range: bouyantRange)
        attributedString.setAttributes([.link: highlightrUrl], range: highlightrRange)
        attributedString.setAttributes([.link: lineNumberUrl], range: lineNumberRange)
        
        aboutTextView.textStorage?.setAttributedString(attributedString)
     
        
        // Define how links should look like within the text view
        aboutTextView.linkTextAttributes = [
            .foregroundColor: NSColor.systemBlue,
            //.underlineStyle: NSUnderlineStyle.single.rawValue,
            .cursor: NSCursor.pointingHand
            
        ]
        aboutTextView.font = NSFont(name: "Monaco", size: 12)
      
    
      
    }
    override func viewWillAppear() {
        super.viewWillAppear()
     self.view.window?.level = .floating
    }



}


