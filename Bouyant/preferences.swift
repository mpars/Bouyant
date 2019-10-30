//
//  preferences.swift
//  Bouyant
//
//  Created by mark on 03/10/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Foundation
class preferences: NSObject {

    static func getAlwaysTransparentPref() -> Int {
        
        let defaults = UserDefaults.standard
        var buttonState : Int? = defaults.integer(forKey: "alwaysTransparent")
        
        if UserDefaults.standard.object(forKey: "alwaysTransparent") == nil {
            buttonState = 0
        }
        return buttonState!
    }
    
    static func setAlwaysTransparentPref(_ buttonState: Int?) {
        let defaults = UserDefaults.standard
        defaults.set(buttonState, forKey: "alwaysTransparent")
    }

    static func getFloatOnTopPref() -> Int {
        
        let defaults = UserDefaults.standard
        var buttonState : Int? = defaults.integer(forKey: "floatOnTop")
        
        if UserDefaults.standard.object(forKey: "floatOnTop") == nil {
            buttonState = 1
        }
        return buttonState!
    }
    
    static func setFloatOnTopPref(_ buttonState: Int?) {
        let defaults = UserDefaults.standard
        defaults.set(buttonState, forKey: "floatOnTop")
    }
    
    static func getShowLineNumbersPref() -> Int {
        
        let defaults = UserDefaults.standard
        var buttonState : Int? = defaults.integer(forKey: "showLineNumbers")
        
        if UserDefaults.standard.object(forKey: "showLineNumbers") == nil {
            buttonState = 0
        }
        return buttonState!
    }
    
    static func setShowLineNumbersPref(_ buttonState: Int?) {
        let defaults = UserDefaults.standard
        defaults.set(buttonState, forKey: "showLineNumbers")
    }


}
