//
//  Document.swift
//  Bouyant
//
//  Created by mark on 25/09/2019.
//  Copyright © 2019 Mark Parsons. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    @objc let model = TextFileType(contents: "", typeName: "public.plain-text", typeLanguage: "plaintext")
    //var contents = ""
    
   // var viewController: ViewController? {
   //     return windowControllers.first?.contentViewController as? ViewController
   // }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
       
    }
    
    
    
    override class var autosavesInPlace: Bool {
        return false 
    }
    override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
        return true
    }
    
    override class func canConcurrentlyReadDocuments(ofType: String) -> Bool {
        return true
    }
    
   
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
    //    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    //    let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
     //   self.addWindowController(windowController)
        
     //   if let viewController = windowController.contentViewController as? ViewController {
      //      viewController.representedObject = model
     //   }
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        if let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as? WindowController {
            self.addWindowController(windowController)
            
            if let viewController = windowController.contentViewController as? ViewController {
                viewController.representedObject = model
            }
        }
    }
    
    
    
    override func read(from data: Data, ofType typeName: String) throws {
        model.read(from: data, ofType: typeName)
    }
    
    override func data(ofType typeName: String) throws -> Data {
        
        return model.data(ofType: typeName)!
    }
    
    //verride func data(ofType typeName: String) throws -> Data {
       // // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
      //  // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
    //    if let textView = viewController?.textView {
         //   contents = textView.string

           // return contents.data(using: .utf8) ?? Data()
        //}
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    //}
    
    //override func read(from data: Data, ofType typeName: String) throws {
       
      //  if let fileContents = String(data: data, encoding: .utf8) {
        //    contents = fileContents
            
        //} else {
          //  Swift.print("Error reading file")
            //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        //}
   // }
    
    
}
