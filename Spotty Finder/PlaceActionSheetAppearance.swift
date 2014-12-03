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
            switch buttonIndex {
            case 1:
                sendMessage()
            case 2:
                removePlace()
            case 3:
                
                getPrompt({result in
                    (self.place! as NamedPlace).name = result!
                    self.place!.annotationView().setSelected(false, animated:false)
                    self.uiView!.navigation.places.saveState()
                })
                
            default:
                println("default")
            }
        }
    }
    
    func sendMessage() {
        let message = self.place!.sendMessage(type: 0)
        let messageComposeVC = self.uiView!.messageComposer.configuredMessageComposeViewController(messageBody: message)
        self.uiView!.presentViewController(messageComposeVC, animated: true, completion: nil)
    }
    
    func removePlace() {
        self.uiView!.mapKitView.removeAnnotation(place)
        self.uiView!.navigation.places.deletePlace(place!.idInArray!)
        self.uiView!.navigation.removeTarget()
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
