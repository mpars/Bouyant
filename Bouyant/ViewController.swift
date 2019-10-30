//
//  ViewController.swift
//  Bouyant
//
//  Created by mark on 25/09/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Cocoa
import Highlightr

class ViewController: NSViewController, NSTextViewDelegate {
    
    
    // Variables
    var rulerShown: Bool = false
    var ignoreEvents: Bool = false
    var windowIsTransparent: Bool = false
    var floatOnTop: Bool = true
    
    // variable for interface style
    var inDarkMode: Bool {
        let mode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
        return mode == "Dark"
    }
    
    // ib outlets
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var optionsButton: NSButton!
    @IBOutlet var popUpMenu: NSMenu!
    @IBOutlet weak var languagesPopUpButton: NSPopUpButton!
    
    @IBOutlet weak var wordCountLabel: NSTextField!
    
    @IBOutlet weak var charPosLabel: NSTextField!
    // setup highlightr
    
    let highlightrTextStorage: CodeAttributedString? = CodeAttributedString()
    
    //let transparentSlider = NSSlider()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: NSApplication.willResignActiveNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(appBecomesActive), name: NSApplication.willBecomeActiveNotification, object: nil)
        
        
        // setup font for text view
        
        if let fontStyle = NSFont(name: "Monaco", size: 12) {
            textView.font = fontStyle
        }
        
        // Setup linenumbers ruler for textView
        textView.lnv_setUpLineNumberView()
        
        // Setup other interface elements
        optionsButton.menu = popUpMenu
        
        // assign menu states as per preferences
        popUpMenu.item(withTitle: "Line Numbers")?.state = convertToNSControlStateValue(preferences.getShowLineNumbersPref())
        let menuState = (popUpMenu.item(withTitle: "Line Numbers")?.state)!
        if menuState.rawValue == 1 {
        textView.isHorizontallyResizable = false  // makes textview resize
        textView.enclosingScrollView?.rulersVisible = true
            rulerShown = true
        }
        
        if let storage = highlightrTextStorage {
            storage.addLayoutManager(textView.layoutManager!)
            languagesPopUpButton.removeAllItems()
            languagesPopUpButton.addItems(withTitles: storage.highlightr.supportedLanguages().sorted())
            //let languages = ["plaintext", "bash", "swift", "objectivec", "vbnet","css","html"]
            //languagesPopUpButton.addItems(withTitles: languages)
            
            //themePopUp.removeAllItems()
            //themePopUp.addItems(withTitles: storage.highlightr.availableThemes().sorted())
            
            
            
        }
        

       
        
        
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        //Set up notification for change in dark/light mode
        listenToInterfaceChangesNotification()
        

        
        // Set up notification for when app gains focus
        
        //self.view.window?.alphaValue = 0.7
        
        if let storage = highlightrTextStorage, let language = document?.model.docTypeLanguage {
            languagesPopUpButton.selectItem(withTitle: language)
            storage.language = language
        }
        
        // Fill the text view with the document's contents.
        //if let document = self.view.window?.windowController?.document as? Document {
          //  textView.string = document.contents
            
          //  self.view.window?.alphaValue = 0.7
        //self.view.window?.backgroundColor = NSColor(white: 1, alpha: 0.7)
        //}
        
        // set up window style
        view.window?.level = .floating
        //view.window?.isOpaque = false
        
        //view.window?.ignoresMouseEvents = true
        //view.window?.titlebarAppearsTransparent = false
        
        //view.window?.titlebarAppearsTransparent = true
        //view.window?.alphaValue = 0.7
        //self.textView.alphaValue = 0.7
        checkModeLightDark()
        wordCount()
        
    }
    

    

    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
           for child in children {
                child.representedObject = representedObject
            }
       }
    }
    
    // setup listening to notifications
    func listenToInterfaceChangesNotification() {
        DistributedNotificationCenter.default.addObserver(
            self,
            selector: #selector(interfaceModeChanged),
            name: .AppleInterfaceThemeChangedNotification,
            object: nil
        )
    }
    
    // delegate helpers
    weak var windowController: WindowController? {
        return view.window?.windowController as? WindowController
    }
    weak var document: Document? {
        if let window = windowController, let doc = window.document as? Document {
            return doc
        }
        return nil
    }
    // textView Delegate
    
    func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
   
        return false
    }
    
    func textDidChange(_ notification: Notification) {
            wordCount()
    }
    
    func textViewDidChangeSelection(_ notification: Notification) {
        let insertionPointIndex = textView.selectedRanges.first!.rangeValue.location
        charPosLabel.stringValue = String(insertionPointIndex)
        //print(insertionPointIndex ?? "nothing")
    }
    
 
    func wordCount() {
        let textStorage = textView.textStorage
        let words = textStorage!.words.count
        wordCountLabel.stringValue = String(words)
        
        


        //let selectedRange = self.textView.selectedRanges.last
        //print(selectedRange ?? "No Selected")
        

    }

    
    @objc func appMovedToBackground() {
        if ignoreEvents {
            view.window?.ignoresMouseEvents = true
            view.window?.alphaValue = 0.7
        }else{
            view.window?.ignoresMouseEvents = false
            view.window?.alphaValue = 0.7
        }
    }
    
    @objc func appBecomesActive() {
        if windowIsTransparent == true {
        view.window?.titlebarAppearsTransparent = true
        view.window?.alphaValue = 0.7
        appsWindows(windows: NSApp.windows, becomingActive: true, ignore: false)
        }else{
            view.window?.titlebarAppearsTransparent = true
            view.window?.alphaValue = 1
            appsWindows(windows: NSApp.windows, becomingActive: true, ignore: false)
        }
    }
    
    @objc func interfaceModeChanged() {
        checkModeLightDark()
    }
    
    func checkModeLightDark() {
        
        if inDarkMode {
            //view.window?.backgroundColor = NSColor(white: 0.2, alpha: 0.5)
            if windowIsTransparent == true {
                view.window?.alphaValue = 0.7
            //self.textView.backgroundColor = NSColor(white: 0.2, alpha: 0.7)
            }else{
                //self.textView.backgroundColor = NSColor(white: 0.2, alpha: 1)
                view.window?.alphaValue = 1
            }
            // dont need this now
            //view.window?.alphaValue = 0.7
            //self.textView.alphaValue = 0.8
            if let storage = highlightrTextStorage {
                storage.highlightr.setTheme(to: "tomorrow-night-eighties")
                storage.highlightr.theme.codeFont = NSFont(name: "monaco", size: 12)
            }
        } else {
            
            //view.window?.backgroundColor = NSColor(white: 1, alpha: 0.5)
            if windowIsTransparent == true {
                view.window?.alphaValue = 0.7
            //self.textView.backgroundColor = NSColor(white: 1, alpha: 0.7)
            }else{
                view.window?.alphaValue = 1
                //self.textView.backgroundColor = NSColor(white: 1, alpha: 1)
            }
            
            // dont need this either
            
            //view.window?.alphaValue = 0.7
            //self.textView.alphaValue = 0.8
            if let storage = highlightrTextStorage {
                storage.highlightr.setTheme(to: "tomorrow")
                storage.highlightr.theme.codeFont = NSFont(name: "monaco", size: 12)
            }
        }
    }
    
    
    @IBAction func languagesPopUpButtonAction(_ sender: NSPopUpButton) {
        
            if let storage = highlightrTextStorage {
                storage.language = sender.titleOfSelectedItem //?? userPreferences.language
                if sender.titleOfSelectedItem == "plaintext" as String? {
                    
                    
                    if inDarkMode {
                        storage.highlightr.setTheme(to: "vs2015")
                        storage.highlightr.theme.codeFont = NSFont(name: "monaco", size: 12)
                    }else{
                        storage.highlightr.setTheme(to: "xcode")
                        storage.highlightr.theme.codeFont = NSFont(name: "monaco", size: 12)
                    }
                }else{
                    if inDarkMode {
                        storage.highlightr.setTheme(to: "tomorrow-night-eighties")
                        storage.highlightr.theme.codeFont = NSFont(name: "monaco", size: 12)
                    }else{
                        storage.highlightr.setTheme(to: "tomorrow")
                        storage.highlightr.theme.codeFont = NSFont(name: "monaco", size: 12)
                    }
                }
                //storage.highlightr.setTheme(to: "default")
            
    }
    }
    @IBAction func themePopUpAction(_ sender: NSPopUpButton) {
        
        if let storage = highlightrTextStorage {
            storage.highlightr.setTheme(to: sender.titleOfSelectedItem ?? "default")
        }
    }
    
    
    @IBAction func optionsButtonClicked(_ sender: NSButtonCell) {
        popUpMenu.popUp(positioning: popUpMenu.item(at: 0), at: NSEvent.mouseLocation, in: nil)
        
        //textView.lnv_setUpLineNumberView()
        //view.window?.backgroundColor = NSColor(white: 1, alpha: 1)
        //self.textView.backgroundColor = NSColor(white: 1, alpha: 1)
    }
    
    func appsWindows(windows: [NSWindow], becomingActive:Bool, ignore: Bool) {
        for window in windows {
            // ignore is ignore mouseevents,
            if ignore {
                window.ignoresMouseEvents = true
            }else{
                window.ignoresMouseEvents = false
            }
            if becomingActive {
            }else{
                
                //window.alphaValue = 0.7
            }
        }
  
    }
    
    @IBAction func lineNumbersMenuItemClicked(_ sender: NSMenuItem) {
        if rulerShown == false {
            sender.state = NSControl.StateValue.on
            textView.isHorizontallyResizable = false  // makes textview resize
            textView.enclosingScrollView?.rulersVisible = true
            //textView.lineNumberView.needsDisplay = true
            //textView.lineNumberView.ruleThickness = 40
            rulerShown = true
            
        }else{
            sender.state = NSControl.StateValue.off
            textView.isHorizontallyResizable = true  // makes textview resize
            textView.enclosingScrollView?.rulersVisible = false
            //textView.lineNumberView.needsDisplay = true
            //textView.lineNumberView.ruleThickness = 0
            rulerShown = false
            
        }
    }
    
    
    
    @IBAction func transparentMenuItemClicked(_ sender: NSMenuItem) {
        if sender.state == NSControl.StateValue.on {
            sender.state = NSControl.StateValue.off
            view.window?.alphaValue = 1
            windowIsTransparent = false
            checkModeLightDark()
            
        }else{
            sender.state = NSControl.StateValue.on
            view.window?.alphaValue = 0.7
            windowIsTransparent = true
            checkModeLightDark()
            //self.textView.backgroundColor = NSColor(white: 1, alpha: 0.7)
            //self.textView.alphaValue = 0.7
        }
    }
    

    @IBAction func floatOnTopMenuItemClicked(_ sender: NSMenuItem) {
        if sender.state == NSControl.StateValue.on {
            sender.state = NSControl.StateValue.off
            view.window?.level = .normal
        }else{
            sender.state = NSControl.StateValue.on
            view.window?.level = .floating
        }
    }
    
 
    @IBAction func allowClickThroughMenuItemClicked(_ sender: NSMenuItem) {
        if sender.state == NSControl.StateValue.on {
            sender.state = NSControl.StateValue.off
            ignoreEvents = false
        }else{
            sender.state = NSControl.StateValue.on
            ignoreEvents = true
        }
    }

    
    
    
}

// Helper function
fileprivate func convertToNSControlStateValue(_ input: Int) -> NSControl.StateValue {
    return NSControl.StateValue(rawValue: input)
}

extension Notification.Name {
    static let AppleInterfaceThemeChangedNotification = Notification.Name("AppleInterfaceThemeChangedNotification")
    
}

