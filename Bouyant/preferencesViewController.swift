//
//  preferencesViewController.swift
//  Bouyant
//
//  Created by mark on 30/09/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Cocoa
import Highlightr

class preferencesViewController: NSViewController {
    
    let defaults:UserDefaults = UserDefaults.standard

    @IBOutlet weak var alwaysTransparentButton: NSButton!
    @IBOutlet weak var floatOnTopButton: NSButton!
    @IBOutlet weak var showLineNumbers: NSButton!
    @IBOutlet weak var syntaxPopUpButton: NSPopUpButton!
    @IBOutlet weak var fontSizePop: NSPopUpButton!
    @IBOutlet weak var fontPop: NSPopUpButton!

    @IBOutlet weak var alwaysTransparencySlider: NSSlider!
    
    @IBOutlet weak var backgroundTransparencySlider: NSSlider!
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.level = .floating
        //lazy var window: NSWindow! = self.view.window
        self.view.window?.styleMask.remove(.resizable)
        self.view.window?.title = "Preferences"
        
        let highlightrTextStorage: CodeAttributedString? = CodeAttributedString()
        if let storage = highlightrTextStorage {
        syntaxPopUpButton.removeAllItems()
        syntaxPopUpButton.addItems(withTitles: storage.highlightr.supportedLanguages().sorted())
            syntaxPopUpButton.setTitle("plaintext")
        }
        
        getPreferences()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    @IBAction func alwaysTransparentButtonClicked(_ sender: NSButton) {
        let buttonState = self.alwaysTransparentButton.state
        preferences.setAlwaysTransparentPref(buttonState.rawValue)
    }
    
    
    @IBAction func floatOnTopButtonClicked(_ sender: NSButton) {
        let buttonState = self.floatOnTopButton.state
        preferences.setFloatOnTopPref(buttonState.rawValue)
    }
    
    @IBAction func showLineNumbersButtonClicked(_ sender: NSButton) {
        let buttonState = self.showLineNumbers.state
        preferences.setShowLineNumbersPref(buttonState.rawValue)
    }
    
    @IBAction func alwaysTransparencySliderChanged(_ sender: Any) {
        guard let slider = sender as? NSSlider,
            let event = NSApplication.shared.currentEvent else { return }
        
        switch event.type {
        case .leftMouseDown, .rightMouseDown:
            view.window?.alphaValue = CGFloat(slider.doubleValue/10)
        case .leftMouseUp, .rightMouseUp:
            view.window?.alphaValue = 1
        case .leftMouseDragged, .rightMouseDragged:
            view.window?.alphaValue = CGFloat(slider.doubleValue/10)
        default:
            break
        }
    }
    @IBAction func backgroundTransparencySliderChanged(_ sender: Any) {
        guard let slider = sender as? NSSlider,
            let event = NSApplication.shared.currentEvent else { return }
        switch event.type {
        case .leftMouseDown, .rightMouseDown:
            view.window?.alphaValue = CGFloat(slider.doubleValue/10)
        case .leftMouseUp, .rightMouseUp:
            view.window?.alphaValue = 1
        case .leftMouseDragged, .rightMouseDragged:
            view.window?.alphaValue = CGFloat(slider.doubleValue/10)
        default:
            break
        }
    }
    
    @IBAction func okButtonPressed(_ sender: NSButton) {
        // Save preferences
        
        self.dismiss(self)
    }
    
    func getPreferences(){
        
        self.alwaysTransparentButton.state = convertToNSControlStateValue(preferences.getAlwaysTransparentPref())
        self.floatOnTopButton.state = convertToNSControlStateValue(preferences.getFloatOnTopPref())
        self.showLineNumbers.state = convertToNSControlStateValue(preferences.getShowLineNumbersPref())
    }
}

// Helper function
fileprivate func convertToNSControlStateValue(_ input: Int) -> NSControl.StateValue {
    return NSControl.StateValue(rawValue: input)
}
