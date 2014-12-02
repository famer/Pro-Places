//
//  PlaceActionSheetAppearance.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 28.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//


import UIKit
import Foundation


class PlaceActionSheetAppearance: NSObject, UIActionSheetDelegate {
    override init() {}
    
    var uiView: ViewController?
    var place: NamedPlace?
    
    
    func setUIView(uiview: ViewController) {
        self.uiView = uiview
    }
    
    func setPlace(place: NamedPlace?) {
        self.place = place
    }
    
    func actionSheet(sheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        if sheet.tag == 1 {
            //println(buttonIndex)
            //println(sheet.buttonTitleAtIndex(buttonIndex))
            if (buttonIndex == 2) {
                self.uiView!.mapKitView.removeAnnotation(place)
                //println(place!.idInArray!)
                self.uiView!.navigation.places.deletePlace(place!.idInArray!)
                self.uiView!.navigation.removeTarget()
            }
            if (buttonIndex == 3) {
                
                self.getPrompt({result in
                    println(result!)
                    //(self.place! as NamedPlace).annotationView().setSelected(false, animated:false)
                    (self.place! as NamedPlace).name = result!
                    //(self.place! as NamedPlace).annotationView().setSelected(true, animated:false)// = "asdf"
                    self.uiView!.navigation.places.saveState()
                })
                
            }
        }
    }
    
    func getPrompt(completionBlock: ((String?) -> ())) {
        var inputTextField: UITextField?
        let alert = UIAlertController(title: "Enter Name", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            completionBlock(inputTextField!.text)
            // Now do whatever you want with inputTextField (remember to unwrap the optional)
        }))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Name"
            textField.autocapitalizationType = .Sentences
            inputTextField = textField
        })
        
        self.uiView!.presentViewController(alert, animated: true, completion: nil)
        //self.uiView!.presentViewController(alert, animated: true, completion: nil)
    }
}
