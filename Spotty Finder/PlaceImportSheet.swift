//
//  PlaceImportActionSheet.swift
//  Places
//
//  Created by Тимур Татаршаов on 13.12.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//


import UIKit
import Foundation


class PlaceImportSheet: NSObject, UIActionSheetDelegate {
    override init() {}
    
    var uiView: ViewController?
    var place: NamedPlace?
    var sheet: UIActionSheet = UIActionSheet()
    
    func setSheet() -> UIActionSheet? {
        if let setPlace = place {
            sheet.title  = setPlace.title
            sheet.addButtonWithTitle("Cancel")
            sheet.addButtonWithTitle("QR-code")
            sheet.addButtonWithTitle("Search")
            sheet.addButtonWithTitle("Input coordinates")
            sheet.cancelButtonIndex = 0
            sheet.delegate = self
            return sheet
        } else {
            println("You must set place to work with first")
        }
        return nil
    }
    
    func showSheet() {
        sheet.showInView(uiView!.view)
    }
    
    
    func setUIView(uiview: ViewController) {
        self.uiView = uiview
    }
    
    func setPlace(place: NamedPlace?) {
        self.place = place
    }
    
    func actionSheet(sheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
            
            switch buttonIndex {
            case 1:
                sendMessage()
            default:
                println("default")
            }
        
    }
    
    func sendMessage() {
        let message = self.place!.sendMessage(type: 0)
        let messageComposeVC = self.uiView!.messageComposer.configuredMessageComposeViewController(messageBody: message)
        self.uiView!.presentViewController(messageComposeVC, animated: true, completion: nil)
    }
    
}
