//
//  ProgrammaticallyCreatedUI.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 01.12.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation

class ProgrammaticallyCreatedUI {
    
    var uiView: ViewController?
    
    init() {}
    
    func overviewButton() -> UIButton {
        let disclosureButton = UIButton.buttonWithType(.DetailDisclosure) as UIButton
        disclosureButton.frame = CGRect(x: 280.0, y: 400.0, width: 35.0, height: 35.0)
        //disclosureButton.setBackgroundImage(image, forState:.Normal)
        disclosureButton.addTarget(self, action: "overviewAction:", forControlEvents: .TouchDown)
        disclosureButton.addTarget(self, action: "overviewActionCancel:", forControlEvents: .TouchUpInside)
        
        //disclosureButton.setType(.DetailDisclosure)
        return disclosureButton
        //view.addSubview(disclosureButton)
    }
    
    @IBAction func overviewAction(button: UIButton) {
        /*if let mapKitView = uiView?.mapKitView {
            mapKitView.showAnnotations(mapKitView.annotations, animated: true)
        }*/
        /*
        if let mapViewManipulations = uiView?.mapViewManipulations {
            mapViewManipulations.overView = true
        }
*/
        uiView?.mapViewManipulations.overView = true
        uiView?.mapViewManipulations.updateMapUI()
        
    }
    
    @IBAction func overviewActionCancel(button: UIButton) {
        /*if let mapKitView = uiView?.mapKitView {
        mapKitView.showAnnotations(mapKitView.annotations, animated: true)
        }*/
        uiView?.mapViewManipulations.overView = false
        uiView?.mapViewManipulations.updateMapUI()
    }
}