//
//  TextFileTypes.swift
//  Bouyant
//
//  Created by mark on 27/09/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Foundation

class TextFileType: NSObject {
    
    @objc dynamic var content: String
    @objc dynamic var docTypeName: String
    @objc dynamic var docTypeLanguage: String
    
    public init(contents: String, typeName: String, typeLanguage: String) {
        self.content = contents
        self.docTypeName = typeName
        self.docTypeLanguage = typeLanguage
    }
    
}

extension TextFileType{
    
    func read(from data: Data, ofType typeName: String) {
        docTypeName = typeName
        docTypeLanguage = getLanguageForType(typeName: docTypeName)
        content = String(data: data, encoding: .utf8) ?? "File Not Recognised"
    }
    
    func data(ofType typeName: String) -> Data? {
        
        docTypeName = typeName
        docTypeLanguage = getLanguageForType(typeName: docTypeName)
        return content.data(using: .utf8)
    }
    
}

extension TextFileType {
    
    func getLanguageForType(typeName: String) -> String {
        guard let plistPath = Bundle.main.path(forResource: "LanguagesUTI", ofType: "plist"),
            let languagesFromUTI = NSDictionary(contentsOfFile: plistPath),
            let language = languagesFromUTI[typeName] as? String else {
                print("Unknown doctTypeName: \(docTypeName)")
                return "plaintext"
        }
        return language
    }
    
}
